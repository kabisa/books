class BookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    identified?
  end

  def update?
    identified?
  end

  def destroy?
    identified?
  end

  def restore?
    identified?
  end

  def borrow?
    identified?
  end

  private
  def identified?
    user.identified?
  end
end
