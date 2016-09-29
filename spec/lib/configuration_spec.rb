require 'spec_helper'

module Pickpocket
  RSpec.describe Configuration do
    before(:each) { Pickpocket.reset }

    subject(:config) { Pickpocket.config }

    describe 'default configurations' do
      it { expect(config.home_folder).to eq(File.expand_path('~/.pickpocket')) }
      it { expect(config.authorization_token_file).to eq(File.expand_path('~/.pickpocket/authorization_token')) }
      it { expect(config.oauth_token_file).to eq(File.expand_path('~/.pickpocket/oauth_token')) }
      it { expect(config.article_list_file).to eq(File.expand_path('~/.pickpocket/article_list')) }

      it { expect(config.consumer_key).to eq('58132-f824d5fbf935681e22e86a3c') }
      it { expect(config.pocket_homepage).to eq('https://getpocket.com') }
      it { expect(config.pocket_oauth_authorize_url).to eq('https://getpocket.com/v3/oauth/authorize') }
      it { expect(config.pocket_oauth_request_url).to eq('https://getpocket.com/v3/oauth/request') }
      it { expect(config.pocket_retrieve_url).to eq('https://getpocket.com/v3/get') }
      it { expect(config.pocket_send_url).to eq('https://getpocket.com/v3/send') }
      it { expect(config.pocket_user_authorize_url).to eq('https://getpocket.com/auth/authorize') }
    end

    it 'allows gem configuration' do
      Pickpocket.configure { |c| c.pocket_homepage = 'https://www.github.com' }

      expect(config.pocket_homepage).to eq('https://www.github.com')
    end

    it 'allows resetting configuration' do
      Pickpocket.configure { |c| c.pocket_homepage = 'https://www.github.com' }
      Pickpocket.reset

      expect(config.pocket_homepage).to eq('https://getpocket.com')
    end
  end
end
