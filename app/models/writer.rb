class Writer < ApplicationRecord
  validates :name, presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 255 }

  has_and_belongs_to_many :books
end
