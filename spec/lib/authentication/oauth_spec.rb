require 'spec_helper'
require 'support/setup/vcr'

module Pickpocket::Authentication
  RSpec.describe Oauth, :vcr do
    let(:tempfile) { Tempfile.new('tempfile_logger') }
    let(:tempfile_logger) { ::Logger.new(tempfile) }
    let(:oauth) { described_class.new }

    before(:each) do
      oauth.logger = tempfile_logger
    end

    describe '#request_authorization' do
      it 'requests authorization from pocket, saving its token and printing given URL' do
        oauth.request_authorization

        token_handler = oauth.token_handler
        tempfile.rewind

        expect(tempfile.read).to include('https://getpocket.com/auth/authorize?request_token=5694adeb-fa9c-c95c-3b82-ab1d33&redirect_uri=https://getpocket.com')
        expect(token_handler.read_oauth).to eq('5694adeb-fa9c-c95c-3b82-ab1d33')
      end
    end

    describe '#authorize' do
      it "authorizes Pickpocket using user's token, saving it to authorization_token" do
        oauth.authorize
        result = oauth.token_handler.read_authorization
        expect(result).to eq('49858549-532d-55b1-62bc-21bf5b')
      end
    end
  end
end
