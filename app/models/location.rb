class Location < ApplicationRecord
  validates :city, presence: true, length: { maximum: 255 }

  def to_label
    city
  end
end
