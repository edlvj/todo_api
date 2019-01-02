module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from Pundit::NotAuthorizedError, with: :forbidden
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::InvalidToken, with: :unprocessable_entity
    rescue_from ExceptionHandler::ExpiredSignature, with: :invalid_token
    rescue_from ExceptionHandler::DecodeError, with: :invalid_token

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def forbidden
    render json: { message: "Not allowed." }, status: :forbidden
  end

  def unprocessable_entity(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def invalid_token(e)
    render json: { message: e.message }, status: :unauthorized
  end

  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end
end