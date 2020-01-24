class Copy < ApplicationRecord
  belongs_to :book
  belongs_to :location
  has_many :borrowings, dependent: :destroy

  validates :number, numericality: { greater_than: 0, only_integer: true }
  validate :duplicate_locations_not_allowed

  acts_as_paranoid
  delegate :to_s, to: :book

  # @return true if there's still a copy that can be borrowed.
  def borrowable?
    borrowings.size < number
  end

  private

  def duplicate_locations_not_allowed
    if duplicate_location?
      errors.add(:location, :taken)
    end
  end

  def duplicate_location?
    book&.copies&.group_by { |c| c.location_id }&.map { |k, v| [k, v.size] }.to_h.fetch(location_id, 0) > 1
  end
end
