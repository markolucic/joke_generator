module Api
  module V1
    class JokesController < ApplicationController
      def index
        response = JokeApiService.new.call
        jokes = JokeGeneratorService.new(response,
                                         params[:joke_count] || 5).call
        
        render json: { jokes: jokes }
      end
    end
  end
end
