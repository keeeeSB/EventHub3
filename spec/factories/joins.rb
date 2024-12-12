FactoryBot.define do
  factory :join do
    association :user
    association :event
  end
end
