# frozen_string_literal: true

module API
  module V2
    module Endpoints
      class Projects < ::Grape::API
        resource :projects do
          before { authenticate_request }

          # INDEX
          desc 'Returns current user projects', {
            entity: API::V2::Entities::Project,
            notes: 'Get all projects of user.'
          }
          get '/', http_codes: [
            [200, 'Ok'],
            [400, "Bad Request"]
          ] do
            projects = policy_scope(Project)
            present projects, with: API::V2::Entities::Project
          end

          # CREATE
          desc 'Create new project', {
            entity: API::V2::Entities::Project,
            notes: 'Create new task'
          }
          params do
            requires :project, type: Hash do
              requires :title, type: String, desc: 'New task title'
            end
          end

          post '/' do
            @project = Project.new(title: params['project']['title'])
            @project.user = current_user

            if @project.save
              present @project, with: API::V2::Entities::Project
            else
              error! @project.errors
            end
          end

          # PUT
          desc "Update projects", {
            entity: API::V2::Entities::Project,
            notes: 'Update project'
          }

          params do
            requires :id, type: String, desc: 'Project ID'

            requires :project, type: Hash do
              requires :title, type: String, desc: 'New task title'
            end
          end

          put ':id' do
            @project = Project.find(params[:id])
            authorize @project, :update?

            if @project.update_attributes(title: params['project']['title'])
              present @project, with: API::V2::Entities::Project
            else
              error! @project.errors
            end
          end

          ## DELETE
          desc 'Delete project', {
            entity: API::V2::Entities::Project,
            notes: 'Delete project'
          }
          params do
            requires :id, type: String, desc: "Project ID"
          end
          delete ':id' do
            @project = Project.find(params[:id])
            authorize @project, :destroy?

            if @project.destroy
              present @project, with: API::V2::Entities::Project
            else
              error! @project.errors
            end
          end
        end
      end
    end
  end
end