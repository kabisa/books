class BookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    !user.anonymous?
  end

  def borrow?
    !user.anonymous?
  end
end
