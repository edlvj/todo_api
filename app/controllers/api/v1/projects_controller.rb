class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]

  def index
    @projects = policy_scope(Project)
    render jsonapi: @projects
  end

  def create
    @project.new(project_params)

    if @project.save
      render json: @project
    else
      render json: { error: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @project, :update?
    if @project.update_attributes(project_params)
      render json: @project
    else
      render json: { error: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @project, :destroy?
    if @project.destroy
      render json: @project
    else
      render json: { error: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:title)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end