FactoryBot.define do
  factory :book do
    title    { 'MyString' }
    summary  { 'Lorem Ipsum' }
    tag_list { %w(Lorem Ipsum) }
    link { 'http://www.kabisa.nl' }
    num_of_pages { 200 }
    published_on { Date.parse('2004-12-31') }

    transient do
      comments_count { 0 }
      writers_count  { 0 }
      copies_count { 0 }
    end

    after(:build) do |book, evaluator|
      evaluator.copies_count.times do |n|
        book.copies << build(:copy, location: create(:location))
      end
    end

    after(:create) do |book, evaluator|
      create_list(:comment, evaluator.comments_count, book: book)
      create_list(:writer, evaluator.writers_count, :random, books: [book])
    end

    trait :invalid do
      title { '' }
    end

    trait :ebook do
      link { 'http://www.kabisa.nl' }

      trait :random do
        title { Faker::Book.title }
        link { Faker::Internet.url }
        summary { Array.new(rand(6))  { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 5) }.join("\n") }
        tag_list { Array.new(rand(6)) { Faker::ProgrammingLanguage.name } }
        num_of_pages { rand(500) }
        published_on { rand(500).days.ago }

        transient do
          writers_count { rand(4) }
        end
      end
    end

    trait :printed_book do
      link { '' }

      transient do
        copies_count { 1 }
      end

      trait :random do
        title { Faker::Book.title }
        summary { Array.new(rand(6))  { Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 5) }.join("\n") }
        tag_list { Array.new(rand(6)) { Faker::ProgrammingLanguage.name } }
        num_of_pages { rand(500) }
        published_on { rand(500).days.ago }

        transient do
          writers_count { rand(4) }
        end
      end
    end
  end
end
