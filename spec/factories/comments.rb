FactoryBot.define do
  factory :comment do
    body { "MyString" }
    user { User.all.shuffle.first || create(:user) }
    book { nil }
  end
end
