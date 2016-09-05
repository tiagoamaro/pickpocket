require 'json'

module Pickpocket
  module Articles
    class Retrieve
      attr_reader :token_handler

      def initialize
        @token_handler = TokenHandler.new
      end

      def article_list
        @article_list ||= begin
          access_token = token_handler.read
          uri          = URI(POCKET_RETRIEVE_URL)

          result = Net::HTTP.post_form(uri, {
              consumer_key: CONSUMER_KEY,
              access_token: access_token
          })

          JSON.parse(result.body)['list']
        end
      end

      def random_article_id
        article_list.keys.sample
      end
    end
  end
end
