class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    !user.anonymous?
  end

  def destroy?
    !user.anonymous?
  end
end
