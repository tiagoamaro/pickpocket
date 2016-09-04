require 'spec_helper'

describe Pickpocket do
  describe 'constants' do
    it('CONSUMER_KEY') { expect(Pickpocket::CONSUMER_KEY).not_to be nil }
    it('VERSION') { expect(Pickpocket::VERSION).not_to be nil }

    it('POCKET_HOMEPAGE') { expect(Pickpocket::POCKET_HOMEPAGE).to eq('https://getpocket.com') }
    it('POCKET_OAUTH_AUTHORIZE_URL') { expect(Pickpocket::POCKET_OAUTH_AUTHORIZE_URL).to eq('https://getpocket.com/v3/oauth/authorize') }
    it('POCKET_OAUTH_REQUEST_URL') { expect(Pickpocket::POCKET_OAUTH_REQUEST_URL).to eq('https://getpocket.com/v3/oauth/request') }
    it('POCKET_RETRIEVE_URL') { expect(Pickpocket::POCKET_RETRIEVE_URL).to eq('https://getpocket.com/v3/get') }
  end
end
