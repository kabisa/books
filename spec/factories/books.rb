FactoryBot.define do
  factory :book do
    title { 'MyString' }
    summary { 'Lorem Ipsum' }
    tag_list { %w(Lorem Ipsum) }

    trait :invalid do
      title { '' }
    end

    factory :ebook, class: Ebook do
      type { 'Ebook' }
      link { 'http://www.kabisa.nl' }

      trait :random do
        title { Faker::Book.title }
        link { Faker::Internet.url }
        summary { Array.new(rand(6))  { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 5) }.join("\n") }
        tag_list { Array.new(rand(6)) { Faker::ProgrammingLanguage.name } }
      end
    end

    factory :printed_book, class: PrintedBook do
      type { 'PrintedBook' }

      after(:build) do |book, evaluator|
        book.copies << build(:copy)
      end

      trait :random do
        title { Faker::Book.title }
        summary { Array.new(rand(6))  { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 5) }.join("\n") }
        tag_list { Array.new(rand(6)) { Faker::ProgrammingLanguage.name } }
      end
    end
  end
end
