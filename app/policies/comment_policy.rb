class CommentPolicy < ApplicationPolicy
  def create?
    record.task.project.user.id == user.id
  end

  def destroy?
    record.task.project.user.id == user.id
  end

  class Scope < Scope
    def resolve
      scope.joins(task: :project).where("projects.user_id": user.id)
    end
  end
end