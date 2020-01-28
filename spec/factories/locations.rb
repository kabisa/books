FactoryBot.define do
  factory :location do
    city { Faker::Address.unique.city }
  end
end
