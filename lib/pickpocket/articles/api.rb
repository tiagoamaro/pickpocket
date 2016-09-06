require 'json'

module Pickpocket
  module Articles
    class Api
      ACTION_DELETE = 'delete'
      STATE_UNREAD  = 'unread'

      attr_reader :token_handler

      def initialize
        @token_handler = Authentication::TokenHandler.new
      end

      def get_list(state = STATE_UNREAD)
        @article_list ||= begin
          access_token = token_handler.read_auth
          uri          = URI(POCKET_RETRIEVE_URL)
          result       = Net::HTTP.post_form(uri, {
              consumer_key: CONSUMER_KEY,
              access_token: access_token,
              state:        state
          })

          JSON.parse(result.body)['list']
        end
      end

      def delete(article_ids)
        # TODO

        # access_token = token_handler.read_auth
        # json_action  = JSON.generate([{ action: ACTION_DELETE, item_id: article_id }])
        # uri          = URI(POCKET_SEND_URL)
        # Net::HTTP.post_form(uri, {
        #     consumer_key: CONSUMER_KEY,
        #     access_token: access_token,
        #     actions:      json_action
        # })
      end
    end
  end
end
