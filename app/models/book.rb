class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }

  class << self
    def types
      %i(Ebook PrintedBook)
    end

    def policy_class
      BookPolicy
    end
  end
end
