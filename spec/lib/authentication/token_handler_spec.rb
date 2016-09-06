require 'spec_helper'

module Pickpocket::Authentication
  RSpec.describe TokenHandler do
    let(:token_handler) { described_class.new }

    context 'saving tokens' do
      describe '#save_oauth' do
        let(:token_file_path) { Pickpocket.config.oauth_token_file }

        it 'saves token to ~/.pickpocket/oauth_token' do
          token_handler.save_oauth('oauth token!')

          result = File.read(token_file_path)
          expect(result).to eq('oauth token!')
        end
      end

      describe '#save_authorization' do
        let(:token_file_path) { Pickpocket.config.authorization_token_file }

        it 'saves token to ~/.pickpocket/authorization_token' do
          token_handler.save_authorization('authorization token!')

          result = File.read(token_file_path)
          expect(result).to eq('authorization token!')
        end
      end
    end

    context 'reading tokens' do
      context 'file exists' do
        it '#read_oauth' do
          token_handler.save_oauth('reading oauth token!')

          result = token_handler.read_oauth
          expect(result).to eq('reading oauth token!')
        end

        it '#read_authorization' do
          token_handler.save_authorization('reading authorization token!')

          result = token_handler.read_authorization
          expect(result).to eq('reading authorization token!')
        end
      end

      context 'file does not exist' do
        let(:tempfile) { Tempfile.new('fake_logger') }

        before(:each) { token_handler.logger = ::Logger.new(tempfile) }

        it '#read_oauth' do
          FileUtils.rm(Pickpocket.config.oauth_token_file)

          result = token_handler.read_oauth
          tempfile.rewind
          expect(result).to eq(:no_token)
          expect(tempfile.read).to include('OAuth Token file does not exist. Make sure you request authorization before proceeding.')
        end

        it '#read_authorization' do
          FileUtils.rm(Pickpocket.config.authorization_token_file)

          result = token_handler.read_authorization
          tempfile.rewind
          expect(result).to eq(:no_token)
          expect(tempfile.read).to include('Authorization Token file does not exist. Make sure you request authorization before proceeding.')
        end
      end
    end
  end
end
