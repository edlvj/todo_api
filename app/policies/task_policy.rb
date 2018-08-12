class TaskPolicy < ApplicationPolicy
  %w(create? update? destroy?).each do |action|
    define_method action do
      user_project?
    end
  end

  private

  def user_project?
    user.projects.include? record.project
  end
end