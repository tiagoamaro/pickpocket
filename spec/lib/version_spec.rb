require 'spec_helper'

module Pickpocket
  RSpec.describe 'Gem version' do
    it { expect(VERSION).not_to be nil }
  end
end
