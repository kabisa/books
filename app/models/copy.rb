class Copy < ApplicationRecord
  belongs_to :book
  belongs_to :location
  has_many :borrowings, dependent: :destroy

  validates :number, numericality: { greater_than: 0, only_integer: true }, if: :printed_book?
  validate :duplicate_locations_not_allowed

  acts_as_paranoid

  # @return true if there's still a copy that can be borrowed.
  def borrowable?
    borrowings.size < number
  end

  private

  def printed_book?
    book.is_a?(PrintedBook)
  end

  def duplicate_locations_not_allowed
    return unless book && printed_book?

    if duplicate_location?
      errors.add(:location, :taken)
    end
  end

  def duplicate_location?
    book.copies.group_by { |c| c.location_id }[location_id].size > 1
  end
end
