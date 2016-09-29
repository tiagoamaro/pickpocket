require 'fileutils'
require 'yaml/store'

module Pickpocket
  module Articles
    class Library
      attr_reader :read, :unread

      private def store
        FileUtils.mkdir_p(Pickpocket.config.home_folder)
        YAML::Store.new(Pickpocket.config.library_file)
      end

      def initialize
        @read   = []
        @unread = []
      end

      # Library will have two arrays: read and unread
      # Operations:
      # => renew: replace the unread array with the given one
      # => pick: select an unread article, put it to the read collection and return this article
    end
  end
end
