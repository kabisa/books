FactoryBot.define do
  factory :book do
    title { 'MyString' }

    trait :invalid do
      title { '' }
    end

    factory :ebook do
      type { 'Ebook' }
    end

    factory :printed_book do
      type { 'PrintedBook' }
    end
  end
end
