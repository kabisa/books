FactoryBot.define do
  factory :book do
    title { 'MyString' }

    trait :invalid do
      title { '' }
    end

    factory :ebook, class: Ebook do
      type { 'Ebook' }
    end
  end
end
