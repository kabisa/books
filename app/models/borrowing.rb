class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :copy, counter_cache: true

  acts_as_paranoid
end
