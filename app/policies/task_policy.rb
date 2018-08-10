class TaskPolicy < ApplicationPolicy
  def create?
    true
  end

  class Scope < Scope
    def resolve
      scope.join(:project).where('projects.user_id': user.id)
    end
  end
end