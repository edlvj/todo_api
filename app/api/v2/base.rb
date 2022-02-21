# frozen_string_literal: true

require './app/api/v2/defaults'
module API
  module V2
    class Base < ::Grape::API
      #include API::V2::Defaults
      version 'v2', using: :header, vendor: 'todo'
      prefix 'api/v2'
      format :json

      helpers do
        include Pundit::Authorization

        attr_reader :current_user

        def authenticate_request
          command = AuthorizeApiRequest.call(request.headers)

          if command.success?
            @current_user = command.result
          else
            render json: { error: command.errors }, status: :unauthorized
          end
        end
      end

      mount API::V2::Endpoints::Projects
      mount API::V2::Endpoints::Tasks
    end
  end
end