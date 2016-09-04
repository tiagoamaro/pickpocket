require 'uri'
require 'net/http'

module Pickpocket
  class Oauth
    CONSUMER_KEY               = ENV.fetch('POCKET_CONSUMER_KEY', '47753-a5647cc8204da8a727c7d1b5')
    POCKET_HOMEPAGE            = 'https://getpocket.com'
    POCKET_OAUTH_REQUEST_URL   = 'https://getpocket.com/v3/oauth/request'
    POCKET_OAUTH_AUTHORIZE_URL = 'https://getpocket.com/v3/oauth/authorize'

    attr_reader :logger, :token

    def initialize
      @logger = Pickpocket::Logger.new
      @token  = Token.new
    end

    def request_authorization
      uri      = URI(POCKET_OAUTH_REQUEST_URL)
      response = Net::HTTP.post_form(uri, {
          consumer_key: CONSUMER_KEY,
          redirect_uri: POCKET_HOMEPAGE
      })

      response_token = response.body.match(/code=(?<token>.*)/)[:token]
      auth_url       = %Q{https://getpocket.com/auth/authorize?request_token=#{response_token}&redirect_uri=#{POCKET_HOMEPAGE}}

      logger.info %Q{To continue, authorize this app opening the following URL: #{auth_url}}
      token.save(response_token)
    end

    def authorize
      response_token = token.read
      uri            = URI(POCKET_OAUTH_AUTHORIZE_URL)
      Net::HTTP.post_form(uri, {
          consumer_key: CONSUMER_KEY,
          code:         response_token
      })
    end
  end
end
