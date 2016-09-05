require 'spec_helper'

module Pickpocket::Authentication
  RSpec.describe TokenHandler do
    let(:token_file_path) { File.join(Dir.home, '.pickpocket', 'token') }
    let(:token_handler) { described_class.new }

    describe '#save' do
      it 'saves token to user token to ~/.pickpocket/token' do
        token_handler.save('saved token!')

        result = File.read(token_file_path)
        expect(result).to eq('saved token!')
      end
    end

    describe '#read' do
      context 'file exists' do
        it 'reads token from token file' do
          token_handler.save('read token!')

          result = token_handler.read
          expect(result).to eq('read token!')
        end
      end

      context 'file does not exist' do
        let(:tempfile) { Tempfile.new('tempfile_logger') }
        let(:tempfile_logger) { ::Logger.new(tempfile) }

        before(:each) do
          token_handler.logger = tempfile_logger
          FileUtils.rm(token_file_path)
        end

        it 'warns user about token file not existing' do
          result = token_handler.read
          tempfile.rewind

          expect(result).to eq(:no_token)
          expect(tempfile.read).to include('Token file does not exist. Make sure you request authorization before proceeding.')
        end
      end
    end
  end
end
