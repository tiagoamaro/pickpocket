require 'spec_helper'
require 'logger'

module Pickpocket
  RSpec.describe Logger do
    let(:pickpocket_logger) { described_class.new }

    describe 'allows logging override' do
      let(:tempfile) { Tempfile.new('tempfile_logger') }
      let(:tempfile_logger) { ::Logger.new(tempfile) }

      it do
        pickpocket_logger.logger = tempfile_logger
        pickpocket_logger.info('Overriding Logger')

        tempfile.rewind
        result = tempfile.read
        expect(result).to include('Overriding Logger')
      end
    end
  end
end
