require 'spec_helper'
require 'support/setup/vcr'

module Pickpocket::Authentication
  RSpec.describe Oauth, :vcr do
    let(:oauth) { described_class.new }

    describe '#request_authorization' do
      it 'requests authorization from pocket, saving its token and printing given URL' do
        expect(Launchy).to receive(:open).with('https://getpocket.com/auth/authorize?request_token=5694adeb-fa9c-c95c-3b82-ab1d33&redirect_uri=https://getpocket.com')
        expect(oauth.token_handler).to receive(:save_oauth).with('5694adeb-fa9c-c95c-3b82-ab1d33')

        oauth.request_authorization
      end
    end

    describe '#authorize' do
      it "authorizes Pickpocket using user's token, saving it to authorization_token" do
        expect(oauth.token_handler).to receive(:save_auth).with('49858549-532d-55b1-62bc-21bf5b')

        oauth.authorize
      end
    end
  end
end
