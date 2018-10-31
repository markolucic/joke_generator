# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ApiExceptions::JokeApiError do |ex|
    render json: { error: ex.message.to_s }, status: :unprocessable_entity
  end
end
