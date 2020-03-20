class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    true
  end

  def update?
    true
  end

  def permitted_attributes
    [
      :comments_anonymously,
      :avatar, :avatar_cache, :remove_avatar,
      :crop_x, :crop_y, :crop_w, :crop_h
    ]
  end
end
