class Location < ApplicationRecord
  validates :city, presence: true, length: { maximum: 255 }
end
