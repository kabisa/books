class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 1024 }

  belongs_to :user
  belongs_to :book
end
