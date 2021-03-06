class BucketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.admin? || user.projects.include?(record.project)
  end

  def update?
    user.admin? || user.projects.include?(record.project)
  end

  def destroy_translation?
    user.admin? || user.projects.include?(record.project)
  end

  def destroy_translation_key?
    user.admin? || user.projects.include?(record.project)
  end
end
