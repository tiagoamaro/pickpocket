require 'logger'

module Pickpocket
  class Logger
    extend SingleForwardable

    @logger           = ::Logger.new(STDOUT)
    @logger.level     = ::Logger::INFO
    @logger.formatter = proc do |_severity, _datetime, _progname, msg|
      %Q{[Pickpocket] #{msg}\n}
    end

    def_delegators :@logger, :debug, :error, :info, :warn

    def self.logger=(logger)
      @logger = logger
    end
  end
end
