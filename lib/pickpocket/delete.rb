module Pickpocket
  class Deleter
    attr_reader :token_handler, :retriever

    def initializer
      @token_handler = TokenHandler.new
      @retriever     = Retriever.new
    end
  end
end
