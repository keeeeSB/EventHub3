FactoryBot.define do
  factory :review do
    body { Faker::Lorem.paragraph(sentence_count: 2) }
    rating { Faker::Number.between(from: 1, to: 5) }
    association :user
    association :event
  end
end
