require 'cgi'
require 'net/http'
require 'uri'

module Pickpocket
  module Authentication
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

        response_token = CGI::parse(response.body)['code'][0]
        auth_url       = %Q{#{POCKET_USER_AUTHORIZE_URL}?request_token=#{response_token}&redirect_uri=#{POCKET_HOMEPAGE}}

        logger.info %Q{To continue, authorize this app opening the following URL: #{auth_url}}
        token_handler.save(response_token)
      end

      def authorize
        response_token = token_handler.read
        uri            = URI(POCKET_OAUTH_AUTHORIZE_URL)

        response = Net::HTTP.post_form(uri, {
            consumer_key: CONSUMER_KEY,
            code:         response_token
        })

        response_token = CGI::parse(response.body)['access_token'][0]
        token_handler.save(response_token)
      end
    end
  end
end
