require 'logger'

module Pickpocket
  class Logger
    extend Forwardable

    attr_reader :logger
    def_delegators :logger, :info, :warn

    def initialize(logdev = STDOUT)
      @logger           = ::Logger.new(logdev)
      @logger.level     = ::Logger::INFO
      @logger.formatter = proc do |severity, datetime, progname, msg|
        %Q{[Pickpocket] #{msg}\n}
      end
    end
  end
end
