require 'spec_helper'

module Pickpocket
  RSpec.describe Utility do
    describe '.ensure_home_folder' do
      it do
        expect(FileUtils).to receive(:mkdir_p).with(Pickpocket::HOME_FOLDER)

        described_class.ensure_home_folder
      end
    end
  end
end
