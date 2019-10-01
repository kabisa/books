FactoryBot.define do
  factory :book do
    title { 'MyString' }
    summary { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 10) }

    trait :invalid do
      title { '' }
    end

    factory :ebook, class: Ebook do
      type { 'Ebook' }
      link { 'http://www.kabisa.nl' }

      trait :random do
        title { Faker::Book.unique.title }
        link { Faker::Internet.unique.url }
      end
    end

    factory :printed_book, class: PrintedBook do
      type { 'PrintedBook' }

      after(:build) do |book, evaluator|
        book.copies << build(:copy)
      end

      trait :random do
        title { Faker::Book.unique.title }
      end
    end
  end
end
