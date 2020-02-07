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

  def download?
    identified? && record.link?
  end

  def borrow?
    identified? && record.copies.any?
  end

  def permitted_attributes
    if identified?
      [
        :title, :link,
        :cover, :cover_cache, :remove_cover,
        :num_of_pages, :published_on,
        :summary, :writer_names, :tag_list,
        :reedition_id, :reedition_title,
        copies_attributes: [
          :id, :location_id, :number, :_destroy
        ]
      ]
    end
  end

  private
  def identified?
    user.identified?
  end
end
