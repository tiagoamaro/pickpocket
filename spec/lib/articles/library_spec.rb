require 'spec_helper'

module Pickpocket::Articles
  RSpec.describe Library do
    let(:library) { described_class.new }
    let(:store) { library.store }

    describe '#guarantee_inventory' do
      let(:library_file) { Pickpocket.config.library_file }

      it 'guarantees library file existence and read/unread hash' do
        FileUtils.rm_rf(library_file)

        library.guarantee_inventory

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
        let(:articles_hash) { first_article.to_h.merge(second_article.to_h) }

        before(:each) do
          store.transaction { store[:unread] = articles_hash }
        end

        describe 'select an unread article, open it with Launchy and move it to the read hash' do
          it do
            allow(library).to receive(:random_hash_key).and_return('key1')
            expect(Launchy).to receive(:open).with('https://www.example1.com')

            library.pick

            store.transaction do
              expect(store[:read]).to eq(first_article.to_h)
              expect(store[:unread]).to eq(second_article.to_h)
            end
          end

          context 'given a quantity of articles to open' do
            it do
              allow(library).to receive(:random_hash_key).and_return('key1', 'key2')
              expect(Launchy).to receive(:open).with('https://www.example1.com')
              expect(Launchy).to receive(:open).with('https://www.example2.com')

              library.pick(2)

              store.transaction do
                expect(store[:read]).to eq(articles_hash)
                expect(store[:unread]).to eq({})
              end
            end
          end
        end
      end
    end

    describe '#renew' do
      let(:remote_articles) { { 'list' => { 'remote1' => 'remote article 1' } } }
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
          expect(store[:unread]).to eq({ 'remote1' => 'remote article 1' })
        end
      end
    end

    describe '#stats' do
      let(:tempfile) { Tempfile.new('fake_logger') }

      before(:each) do
        library.logger = ::Logger.new(tempfile)
        store.transaction do
          store[:read]   = { article1: {}, article2: {}, article3: {} }
          store[:unread] = { article4: {}, article5: {} }
        end
      end

      it 'outputs the amount of unread/read articles on your store' do


        library.stats

        tempfile.rewind
        log = tempfile.read

        expect(log).to include('You have 3 read articles')
        expect(log).to include('You have 2 unread articles')
      end
    end
  end
end
