require 'cgi'
require 'net/http'
require 'uri'

module Pickpocket
  module Authentication
    class Oauth
      attr_reader :token_handler

      def initialize
        @token_handler = TokenHandler.new
      end

      def request_authorization
        uri      = URI(Pickpocket.config.pocket_oauth_request_url)
        response = Net::HTTP.post_form(uri, {
            consumer_key: Pickpocket.config.consumer_key,
            redirect_uri: Pickpocket.config.pocket_homepage
        })

        response_token = CGI::parse(response.body)['code'][0]
        auth_url       = %Q{#{Pickpocket.config.pocket_user_authorize_url}?request_token=#{response_token}&redirect_uri=#{Pickpocket.config.pocket_homepage}}

        Launchy.open(auth_url)
        token_handler.save_oauth(response_token)
      end

      def authorize
        response_token = token_handler.read_oauth
        uri            = URI(Pickpocket.config.pocket_oauth_authorize_url)

        response = Net::HTTP.post_form(uri, {
            consumer_key: Pickpocket.config.consumer_key,
            code:         response_token
        })

        response_token = CGI::parse(response.body)['access_token'][0]
        token_handler.save_auth(response_token)
      end
    end
  end
end
