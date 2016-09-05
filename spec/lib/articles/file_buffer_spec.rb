require 'spec_helper'

module Pickpocket::Articles
  RSpec.describe FileBuffer do
    let(:file_buffer) { described_class.new }
    let(:sample_hash) { { 'something' => 'in the way', 'she' => 'moves' } }

    describe '#save' do
      it 'saves articles hash as a JSON to ~/.pickpocket/article_list' do
        file_buffer.articles_hash = sample_hash
        file_buffer.save

        file_content = File.read(FileBuffer::ARTICLE_LIST_FILE)
        expect(file_content).to eq("{\"something\":\"in the way\",\"she\":\"moves\"}")
      end
    end

    describe '#read' do
      it 'reads JSON content and parses into @articles_hash' do
        file_buffer.articles_hash = sample_hash
        file_buffer.save

        expect(file_buffer.read).to eq(sample_hash)
        expect(file_buffer.articles_hash).to eq(sample_hash)
      end
    end

    describe '#random_article_id' do
      it 'returns a random key from the stored hash' do
        file_buffer.articles_hash = sample_hash

        result = file_buffer.random_article_id
        expect(%w(something she)).to include(result)
      end
    end

    describe '#delete_article' do
      it 'removes the given key from the articles hash' do
        file_buffer.articles_hash = sample_hash
        file_buffer.delete_article('something')

        expect(file_buffer.articles_hash).to eq({ 'she' => 'moves' })
      end
    end
  end
end
