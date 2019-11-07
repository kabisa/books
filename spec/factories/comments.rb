FactoryBot.define do
  factory :comment do
    body { "MyString" }
    user { User.all.shuffle.first || create(:user) }
    book { nil }


    trait :random do
      body { Array.new(rand(4)+1)  { Faker::Lorem.paragraph(sentence_count: 3, supplemental: true, random_sentences_to_add: 5) }.join("\n") }
      created_at { rand(100).days.ago }
    end
  end
end
