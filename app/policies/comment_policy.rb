class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.identified?
  end

  def destroy?
    user == record.user
  end

  def restore?
    destroy?
  end
end
