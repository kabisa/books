class Copy < ApplicationRecord
  belongs_to :book
  belongs_to :location

  validates :number,  numericality: { greater_than: 0, only_integer: true }
end
