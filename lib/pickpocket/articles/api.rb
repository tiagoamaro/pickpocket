require 'json'

module Pickpocket
  module Articles
    class API
      ACTION_DELETE = 'delete'
      STATE_UNREAD  = 'unread'

      attr_reader :token_handler

      def initialize
        @token_handler = Authentication::TokenHandler.new
      end

      def retrieve
        uri      = URI(Pickpocket.config.pocket_retrieve_url)
        response = Net::HTTP.post_form(uri, {
            consumer_key: Pickpocket.config.consumer_key,
            access_token: access_token,
            state:        STATE_UNREAD
        })
        JSON.parse(response.body)
      end

      def delete(article_ids = [])
        return if article_ids.empty?

        uri         = URI(Pickpocket.config.pocket_send_url)
        json_action = article_ids.each_with_object([]) do |article_id, array|
          array << { action: ACTION_DELETE, item_id: article_id }
        end

        response = Net::HTTP.post_form(uri, {
            consumer_key: Pickpocket.config.consumer_key,
            access_token: access_token,
            actions:      JSON.dump(json_action)
        })
        JSON.parse(response.body)
      end

      private

      def access_token
        token_handler.read_auth
      end
    end
  end
end
