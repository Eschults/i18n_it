class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        projects = user.projects
        projects.map { |p| p.company }.uniq
      end
    end
  end

  def show?
    user.admin? || user.projects.map { |p| p.company == record }.size > 0
  end
end
