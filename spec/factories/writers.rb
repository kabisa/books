FactoryBot.define do
  factory :writer do
    name { "MyString" }

      trait :random do
        name { Faker::Name.unique.name }
      end
  end
end
