FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    start_time { Faker::Time.forward(days: 7, period: :evening) }
    location { Faker::Address.full_address }
    association :user # userモデルとの関連付け
    association :category # categoryモデルとの関連付け
  end
end
