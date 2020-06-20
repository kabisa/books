class Writer < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 255 }

  has_and_belongs_to_many :books

  scope :with_books,
        -> { left_joins(:books).where.not(books: { id: nil }).distinct }

  paginates_per 36
end
