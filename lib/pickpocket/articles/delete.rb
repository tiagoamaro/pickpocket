module Pickpocket
  module Articles
    class Delete
      attr_reader :token_handler

      def initialize
        @token_handler = TokenHandler.new
      end

      def remove(article_id)
        access_token = token_handler.read
        json_action  = JSON.generate([{ action: 'delete', item_id: article_id }])
        uri          = URI(POCKET_SEND_URL)
        Net::HTTP.post_form(uri, {
            consumer_key: CONSUMER_KEY,
            access_token: access_token,
            actions:      json_action
        })
      end
    end
  end
end
