require 'spec_helper'
require 'support/setup/vcr'

module Pickpocket::Articles
  RSpec.describe API do
    let(:api) { described_class.new }

    # Note: Recording new episodes requires a valid OAuth token + Authorization token. To do it so, call:
    # before(:each) do
    #   oauth = Pickpocket::Authentication::Oauth.new
    #   oauth.request_authorization # This will open your browser
    #   sleep 3
    #   oauth.authorize
    # end

    describe '#retrieve', :vcr do
      it "returns parsed retrieve result from pocket's API" do
        result = api.retrieve
        expect(result.keys).to eq(%w(status complete list error search_meta since))
      end
    end

    describe '#delete', :vcr do
      context 'given an array with articles ids' do
        let(:articles_ids) { %w(2148956 11618554 32935338) }

        it 'deletes given articles IDs from pocket' do
          result = api.delete(articles_ids)
          expect(result).to eq({ 'action_results' =>[true, true, true], 'status' =>1})
        end
      end
    end
  end
end
