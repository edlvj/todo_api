class Api::V1::CommentsController < ApplicationController
  before_action :set_comment, only: :destroy

  def index
    @comments = policy_scope(Comment).where("tasks.id": params[:task_id]).where("projects.id": params[:project_id])
    render json: CommentSerializer.new(@comments).serialized_json
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @comment = @task.comments.new(comment_params)

    authorize @comment, :create?

    if @comment.save
      render json: CommentSerializer.new(@comment).serialized_json
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment, :destroy?

    if @comment.destroy
      render json: CommentSerializer.new(@comment).serialized_json
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :attachment)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
