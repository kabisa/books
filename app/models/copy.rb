class Copy < ApplicationRecord
  belongs_to :book
  belongs_to :location

  validates :number, numericality: { greater_than: 0, only_integer: true }, if: :printed_book?

  private

  def printed_book?
    book.is_a?(PrintedBook)
  end
end
