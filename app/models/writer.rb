class Writer < ApplicationRecord
  validates :name, presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 255 }
end
