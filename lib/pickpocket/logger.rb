require 'logger'

module Pickpocket
  class Logger
    extend Forwardable

    attr_accessor :logger
    def_delegators :logger, :debug, :error, :info, :warn

    def initialize
      @logger           = ::Logger.new(STDOUT)
      @logger.level     = ::Logger::INFO
      @logger.formatter = proc do |_severity, _datetime, _progname, msg|
        %Q{[Pickpocket] #{msg}\n}
      end
    end
  end
end
