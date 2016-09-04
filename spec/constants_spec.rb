require 'spec_helper'

describe Pickpocket do
  it { expect(Pickpocket::VERSION).not_to be nil }
  it { expect(Pickpocket::CONSUMER_KEY).not_to be nil }
end
