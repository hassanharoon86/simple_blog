FactoryBot.define do
  factory :like do
    association :user
    association :likeable, factory: :post

    trait :for_post do
      association :likeable, factory: :post
    end
  end
end
