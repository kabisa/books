FactoryBot.define do
  factory :vote do
    like { false }
    dislike { false }
    user { nil }
    book { nil }
  end
end
