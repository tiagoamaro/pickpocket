require 'spec_helper'

module Pickpocket::Articles
  RSpec.describe Library do
    let(:library) { described_class.new }
    let(:store) { library.store }

    describe '.initialize' do
      let(:library_file) { Pickpocket.config.library_file }

      it 'guarantees library file existence and read/unread hash' do
        FileUtils.rm_rf(library_file)

        store = library.store
        store.transaction do
          expect(store[:read]).to eq({})
          expect(store[:unread]).to eq({})
        end
      end
    end

    describe '#pick' do
      context 'no articles to read' do
        let(:tempfile) { Tempfile.new('fake_logger') }

        before(:each) { library.logger = ::Logger.new(tempfile) }

        it 'shows message to the user' do
          library.pick

          tempfile.rewind
          expect(tempfile.read).to include('You have read all articles!')
        end
      end

      context 'there are articles to read' do
        PocketArticle = Struct.new(:key, :resolved_url) do
          def value
            { 'resolved_url' => resolved_url }
          end

          def to_h
            { key => value }
          end
        end

        let(:first_article) { PocketArticle.new('key1', 'https://www.example1.com') }
        let(:second_article) { PocketArticle.new('key2', 'https://www.example2.com') }

        before(:each) do
          allow_any_instance_of(Array).to receive(:sample).and_return('key1')

          store.transaction do
            store[:unread] = {
                first_article.key  => first_article.value,
                second_article.key => second_article.value
            }
          end
        end

        it 'select an unread article, open it with Launchy and move it to the read hash' do
          expect(Launchy).to receive(:open).with('https://www.example1.com')

          library.pick

          store.transaction do
            expect(store[:read]).to eq(first_article.to_h)
            expect(store[:unread]).to eq(second_article.to_h)
          end
        end
      end
    end

    describe '#renew' do
      let(:remote_articles) { { 'list' => 'Article List' } }
      let(:read_articles) { {
          'read1' => 'Anything',
          'read2' => 'Anything'
      } }

      before(:each) do
        store.transaction do
          store[:read]   = read_articles
          store[:unread] = {}
        end
      end

      it 'renew library with pocket content, deleting read and retrieving unread articles' do
        expect(library.api).to receive(:retrieve).and_return(remote_articles)
        expect(library.api).to receive(:delete).with(%w(read1 read2))

        library.renew

        store.transaction do
          expect(store[:read]).to eq({})
          expect(store[:unread]).to eq('Article List')
        end
      end
    end
  end
end
