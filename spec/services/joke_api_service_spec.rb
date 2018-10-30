require 'rails_helper'

RSpec.describe JokeApiService do
  subject(:service) do
    described_class.new.call
  end
  let(:redis) { MockRedis.new }
  let(:api_url) do
    'https://icanhazdadjoke.com/search'
  end
  let(:api_jokes) do
    "Did you hear the one about the guy with the broken hearing aid? Neither did he."
  end

  context 'when valid params' do
    before do
      stub_request(:get, api_url).to_return(body: api_jokes)
    end

    it 'returns list of jokes' do
      expect(service).to eq api_jokes
      expect(Rails.cache.fetch('api_jokes')).to be_present
    end
  end
end
