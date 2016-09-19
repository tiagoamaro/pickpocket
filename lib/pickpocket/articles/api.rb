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

      def retrieve(state = STATE_UNREAD)
        # @article_list = begin
        #   uri    = URI(Pickpocket.config.pocket_retrieve_url)
        #   result = Net::HTTP.post_form(uri, {
        #       consumer_key: Pickpocket.config.consumer_key,
        #       access_token: access_token,
        #       state:        state
        #   })
        #
        #   if result.code == '200'
        #     JSON.parse(result.body)['list']
        #   else
        #     { error: result.body, code: result.code }
        #   end
        # end
      end

      def delete(article_ids)
        # access_token = token_handler.read_auth
        # json_action  = JSON.generate([{ action: ACTION_DELETE, item_id: article_id }])
        # uri          = URI(POCKET_SEND_URL)
        # Net::HTTP.post_form(uri, {
        #     consumer_key: CONSUMER_KEY,
        #     access_token: access_token,
        #     actions:      json_action
        # })
      end

      private

      def access_token
        token_handler.read_auth
      end
    end
  end
end
