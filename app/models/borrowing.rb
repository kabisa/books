class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :copy

  acts_as_paranoid
end
