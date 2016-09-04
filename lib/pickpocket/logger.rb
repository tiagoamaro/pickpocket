require 'logger'

module Pickpocket
  class Logger
    extend Forwardable

    attr_accessor :logger
    def_delegators :logger, :debug, :error, :info, :warn

    def initialize
      @logger           = ::Logger.new(STDOUT)
      @logger.level     = ::Logger::INFO
      @logger.formatter = proc do |severity, datetime, progname, msg|
        %Q{[Pickpocket] #{msg}\n}
      end
    end
  end
end
