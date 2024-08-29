FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph(sentence_count: 2) }
    association :user
  end
end
