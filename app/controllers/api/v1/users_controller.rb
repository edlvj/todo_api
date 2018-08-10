class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[sign_in sign_up]

  def sign_in
    authenticate user_params
  end

  def sign_up
    @user = User.new(user_params)
    if @user.save
      response = { message: 'User created successfully'}
      render json: response, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def authenticate(params)
    command = AuthenticateUser.call(params[:username], params[:password])

    if command.success?
      render json: {
          access_token: command.result,
          message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
