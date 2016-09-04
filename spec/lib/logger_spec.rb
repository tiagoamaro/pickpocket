require 'spec_helper'

module Pickpocket
  RSpec.describe Logger do
    describe 'allows custom logger' do
      let(:tempfile_logger) { Tempfile.new('tempfile_logger') }
      let(:logger) { described_class.new(tempfile_logger) }

      it 'log to custom logger' do
        logger.info('info message')
        logger.warn('warning message')

        tempfile_logger.rewind
        result = tempfile_logger.read
        expect(result).to eq(%Q{[Pickpocket] info message\n[Pickpocket] warning message\n})
      end
    end
  end
end
