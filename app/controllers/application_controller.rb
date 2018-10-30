class ApplicationController < ActionController::API
  rescue_from ApiExceptions::JokeApiError do |ex|
    render json: { error: "#{ex.message}" }, status: 422
  end
end
