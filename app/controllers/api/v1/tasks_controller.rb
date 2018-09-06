class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: %w(update destroy)

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)

    authorize @task, :create?

    if @task.save
      render json: TaskSerializer.new(@task, include: [:comments]).serialized_json
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @task, :update?

    if change_priority && @task.update_attributes(task_params)
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

  def change_priority
    return true unless params[:task][:move_type]

    p params[:task][:move_type]

    case params[:task][:move_type].to_sym
    when :up
      @task.increment_position
    when :down
      @task.decrement_position
    else
      true
    end
  end

  def task_params
    params.require(:task).permit(:title, :deadline, :done)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
