class CommentPolicy < ApplicationPolicy
  def create?
    record.task.project.user.id == user.id
  end

  def destroy?
    record.task.project.user.id == user.id
  end
end