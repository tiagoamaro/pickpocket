require 'spec_helper'

module Pickpocket
  RSpec.describe FileBuffer do
    let(:file_path) { File.expand_path('~/.pickpocket/test/file_buffer_test') }

    describe '#save' do
      let(:content) { ['sample', { content: 2 }] }
      let(:buffer) { described_class.new(file_path: file_path) }

      it 'saves any content (as JSON) to given path' do
        buffer = described_class.new(file_path: file_path)
        buffer.save(content)

        file_content = File.read(file_path)
        expect(file_content).to eq("[\"sample\",{\"content\":2}]")
      end

      context 'raise errors on reading' do
        let(:tempfile) { Tempfile.new('tempfile_logger') }
        let(:tempfile_logger) { ::Logger.new(tempfile) }

        before(:each) do
          buffer.logger = tempfile_logger
        end

        it 'logs error' do
          expect(File).to receive(:dirname).and_raise(IOError, 'Fake Error')

          buffer.save('Anything')
          tempfile.rewind
          expect(tempfile.read).to include('Could not write to file due to: Fake Error')
        end
      end

    end

    describe '#read' do
      let(:content) { { 'Reading' => 'Hash', 'a' => [1, 2, 3] } }
      let(:buffer) { described_class.new(file_path: file_path) }

      it 'reads JSON content, parsing it' do
        buffer.save(content)

        expect(buffer.read).to eq(content)
      end

      context 'raise errors on reading' do
        let(:tempfile) { Tempfile.new('tempfile_logger') }
        let(:tempfile_logger) { ::Logger.new(tempfile) }

        before(:each) do
          buffer.logger = tempfile_logger
        end

        it 'logs error' do
          expect(File).to receive(:read).and_raise(IOError, 'Fake Error')

          buffer.read
          tempfile.rewind
          expect(tempfile.read).to include('Could not read from file due to: Fake Error')
        end
      end
    end
  end
end
