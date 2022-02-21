# frozen_string_literal: true

module API
  module V2
    module Entities
      class Comment < Grape::Entity
        expose :id, documentation: {type: 'integer', desc: 'id'}
        expose :title, documentation: {type: 'string', desc: "Project title"}

        expose :attachment do |object|
          if object.attachment.attached?
            Rails.application.routes.url_helpers.rails_blob_url(object.attachment, disposition: 'attachment', only_path: true)
          end
        end
      end
    end
  end
end