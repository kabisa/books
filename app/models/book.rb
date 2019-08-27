class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }

  class << self
    def policy_class
      BookPolicy
    end
  end

  # Currently there's no need to define a view partial for both e-book and printed book
  # so in both cases we use the same partial.
  # This may change is the future.
  def xto_partial_path
    'books/book'
  end
end
