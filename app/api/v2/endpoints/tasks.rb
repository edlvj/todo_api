# frozen_string_literal: true

module API
  module V2
    module Endpoints
      class Tasks < Grape::API
        resource :projects do
          before { authenticate_request }

          # CREATE
          desc 'Returns current user tasks of project', {
            entity: API::V2::Entities::Task,
            notes: 'Get all tasks for project.'
          }

          params do
            requires :project_id, type: String, desc: 'Project ID'

            requires :task, type: Hash do
              requires :title, type: String, desc: 'Task title'
              requires :deadline, type: String, desc: 'Deadline date'
              requires :done, type: String, desc: 'Status'
            end
          end

          get ':project_id/tasks' do
            @project = Project.find(params[:project_id])
            @task = @project.tasks.new(title: params['task']['title'], deadline: params['task']['deadline'],
                                       done: params['task']['done'])

            authorize @task, :create?

            if @task.save
              present @task, with: API::V2::Entities::Task
            else
              error! @task.errors
            end
          end
        end

        # PUT
        desc 'Update task', {
          entity: API::V2::Entities::Task,
          notes: 'Update task'
        }

        params do
          requires :id, type: String, desc: 'Task ID'
          requires :project_id, type: String, desc: 'Task ID'

          requires :task, type: Hash do
            requires :title, type: String, desc: 'Task title'
            requires :deadline, type: String, desc: 'Deadline date'
            requires :done, type: String, desc: 'Title'
          end
        end

        put ':project_id/tasks/:id' do
          @task = Task.find(params[:id])
          authorize @task, :update?

          if @task.update_attributes(title: params['task']['title'], deadline: params['task']['deadline'],
                                     done: params['task']['done'])
            present @task, with: API::V2::Entities::Task
          else
            error! @task.errors
          end
        end
      end
    end
  end
end