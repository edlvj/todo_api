class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: %w(update destroy)

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(task_params)

    authorize @task, :create?

    if @task.save
      render json: TaskSerializer.new(@task, include: [:comments]).serialized_json
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @task, :update?

    if @task.update_attributes(task_params)
      render json: TaskSerializer.new(@task, include: [:comments]).serialized_json
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @task, :destroy?

    if @task.destroy
      render json: TaskSerializer.new(@task, include: [:comments]).serialized_json
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :deadline, :done)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
