FactoryBot.define do
  factory :writer do
    name { Faker::Name.unique.name }

    trait :with_books do
      transient { books_count { 1 } }
      before(:create) do |writer, evaluator|
        evaluator.books_count.times { writer.books << build(:book) }
      end
    end
  end
end
