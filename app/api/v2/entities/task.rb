# frozen_string_literal: true
require './app/api/v2/entities/comment'

module API
  module V2
    module Entities
      class Task < Grape::Entity
        expose :id, documentation: {type: 'integer', desc: 'id'}
        expose :title, documentation: {type: 'string', desc: 'Project title'}

        expose :tasks, using: API::V2::Entities::Comment
      end
    end
  end
end