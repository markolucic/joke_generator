require 'rails_helper'

RSpec.describe 'Jokes' do
  let(:redis) { MockRedis.new }
  let(:api_url) { 'https://icanhazdadjoke.com/search' }
  let(:api_jokes) { "Did you hear the one about the guy with the broken hearing aid? Neither did he." }

  describe 'GET /api/v1/jokes' do
    context 'response is not cached' do
      before do
        Rails.cache.clear
        stub_request(:get, api_url).to_return(body: api_jokes)
      end

      it 'returns newly created jokes' do
        expect(Rails.cache.fetch('api_jokes')).not_to be_present
        expect(Rails.cache.fetch('new_jokes')).not_to be_present

        get '/api/v1/jokes'

        expect(Rails.cache.fetch('api_jokes')).to be_present
        expect(Rails.cache.fetch('new_jokes')).to be_present
        expect(JSON.parse(response.body)['jokes'].count).to eq 5
      end
    end
    
    context 'response is cached' do
      before do
        stub_request(:get, api_url).to_return(body: "")
      end

      it 'returns cached jokes' do
        expect(Rails.cache.fetch('api_jokes')).to be_present
        expect(Rails.cache.fetch('new_jokes')).to be_present

        get '/api/v1/jokes'

        expect(JSON.parse(response.body)['jokes'].count).to eq 5
      end
    end
  end
end
