class Comment < ApplicationRecord
  default_scope { includes(:user).order(created_at: :desc) }

  validates :body, presence: true, length: { maximum: 1024 }

  belongs_to :user
  belongs_to :book, counter_cache: true

  acts_as_paranoid
end
