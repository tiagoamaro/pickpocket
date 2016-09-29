module Pickpocket
  class Configuration
    attr_accessor :home_folder,
                  :authorization_token_file,
                  :oauth_token_file,
                  :article_list_file,
                  :consumer_key,
                  :pocket_homepage,
                  :pocket_oauth_authorize_url,
                  :pocket_oauth_request_url,
                  :pocket_retrieve_url,
                  :pocket_send_url,
                  :pocket_user_authorize_url

    def initialize
      # Files
      @home_folder                = File.join(Dir.home, '.pickpocket')
      @authorization_token_file   = File.join(@home_folder, 'authorization_token')
      @oauth_token_file           = File.join(@home_folder, 'oauth_token')
      @article_list_file          = File.join(@home_folder, 'article_list')

      # Pocket
      @consumer_key               = ENV.fetch('POCKET_CONSUMER_KEY', '58132-f824d5fbf935681e22e86a3c')
      @pocket_homepage            = 'https://getpocket.com'
      @pocket_oauth_authorize_url = 'https://getpocket.com/v3/oauth/authorize'
      @pocket_oauth_request_url   = 'https://getpocket.com/v3/oauth/request'
      @pocket_retrieve_url        = 'https://getpocket.com/v3/get'
      @pocket_send_url            = 'https://getpocket.com/v3/send'
      @pocket_user_authorize_url  = 'https://getpocket.com/auth/authorize'
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.config
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(config)
  end
end
