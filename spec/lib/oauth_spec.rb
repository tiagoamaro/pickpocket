require 'spec_helper'
require 'support/setup/vcr'

module Pickpocket
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

        expect(tempfile.read).to include('https://getpocket.com/auth/authorize?request_token=e6e388d8-b604-70d6-1f8e-49c2aa&redirect_uri=https://getpocket.com')
        expect(token_handler.read).to eq('e6e388d8-b604-70d6-1f8e-49c2aa')
      end
    end

    describe '#authorize' do
      it "authorizes Pickpocket using user's token" do
        result = oauth.authorize
        expect(result.code).to eq('200')
      end
    end
  end
end
