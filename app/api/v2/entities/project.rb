# frozen_string_literal: true
require './app/api/v2/entities/task'

module API
  module V2
    module Entities
      class Project < Grape::Entity
        expose :id, documentation: {type: 'integer', desc: 'id'}
        expose :title, documentation: {type: 'string', desc: 'Project title'}

        expose :tasks, using: API::V2::Entities::Task
      end
    end
  end
end