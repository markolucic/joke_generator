class JokeGeneratorService
  attr_reader :jokes, :count

  def initialize(jokes, count)
    @jokes = jokes
    @count = count
  end

  def call
    return unless jokes
    generate_new_jokes
  end

  private

  def generate_new_jokes
    Rails.cache.fetch('new_jokes', expires_in: 1.hour) do
      MarkovChains::Generator.new(jokes).get_sentences(count.to_i)
    end
  end
end
