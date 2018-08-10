class Api::V1::TasksController < ApplicationController
  def index
    @tasks = policy_scope(Project).where(project_id: params[:project_id])
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def task_params
  end
end
