class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.admin? || user.projects.include?(record)
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || user.projects.include?(record)
  end
end
