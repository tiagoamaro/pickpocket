require 'uri'
require 'net/http'

module Pickpocket
  class Oauth
    attr_reader :token_handler
    attr_accessor :logger

    def initialize
      @logger        = Pickpocket::Logger.new
      @token_handler = TokenHandler.new
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
      token_handler.save(response_token)
    end

    def authorize
      response_token = token_handler.read
      uri            = URI(POCKET_OAUTH_AUTHORIZE_URL)
      Net::HTTP.post_form(uri, {
          consumer_key: CONSUMER_KEY,
          code:         response_token
      })
    end
  end
end
