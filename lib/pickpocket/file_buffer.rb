require 'json'
require 'fileutils'

module Pickpocket
  class FileBuffer
    attr_accessor :logger
    attr_reader :file_path

    def initialize(file_path:)
      @file_path = file_path
      @logger    = Pickpocket::Logger.new
    end

    # Serialize
    def save(content)
      target_folder = File.dirname(file_path)
      FileUtils.mkdir_p(target_folder)
      file          = File.new(file_path, 'w')
      articles_json = JSON.generate(content)
      file.write(articles_json)
      file.close
    rescue StandardError => e
      logger.info("Could not write to file due to: #{e.message}")
    end

    # Deserialize
    def read
      articles_text = File.read(file_path)
      @content      = JSON.parse(articles_text)
    rescue StandardError => e
      logger.info("Could not read from file due to: #{e.message}")
    end
  end
end
