class Vote < ApplicationRecord
  belongs_to :user

  acts_as_paranoid

  class << self
    def policy_class
      VotePolicy
    end
  end
end
