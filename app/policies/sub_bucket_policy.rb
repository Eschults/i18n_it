class SubBucketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.admin? || user.projects.include?(record.bucket.project)
  end
end
