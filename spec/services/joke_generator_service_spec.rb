# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JokeGeneratorService do
  subject(:service) do
    described_class.new(api_jokes, count).call
  end
  let(:redis) { MockRedis.new }
  let(:count) { 5 }
  let(:api_jokes) do
    'Did you hear the one about the guy with the broken hearing aid? Neither did he.'
  end

  context 'when valid params' do
    it 'returns list of jokes' do
      expect(service.count).to eq 5
      expect(Rails.cache.fetch('new_jokes')).to be_present
    end
  end
end
