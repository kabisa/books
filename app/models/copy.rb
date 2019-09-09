class Copy < ApplicationRecord
  belongs_to :book
  belongs_to :location
  has_many :borrowings

  validates :number, numericality: { greater_than: 0, only_integer: true }, if: :printed_book?
  validate :duplicate_locations_not_allowed

  private

  def printed_book?
    book.is_a?(PrintedBook)
  end

  def duplicate_locations_not_allowed
    return unless book && printed_book?

    if has_duplicate_location?
      errors.add(:location, :taken)
    end
  end

  def has_duplicate_location?
    book.copies.group_by { |c| c.location_id }[location_id].size > 1
  end
end
