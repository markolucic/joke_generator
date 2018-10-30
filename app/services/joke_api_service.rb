class JokeApiService
  include HTTParty

  base_uri 'https://icanhazdadjoke.com'

  HEADERS = {
    Accept: 'text/plain'
  }.freeze

  def call
    get_all_jokes
  end

  private

  def get_all_jokes
    Rails.cache.fetch('api_jokes', expires_in: 12.hours) do
      response = self.class.get('/search', headers: HEADERS)
      unless response.success?
        Rails.cache.delete('api_jokes')
        raise ApiExceptions::JokeApiError 
      end
      response.parsed_response
    end
  rescue StandardError
    Rails.cache.delete('api_jokes')
    raise ApiExceptions::JokeApiError
  end
end
