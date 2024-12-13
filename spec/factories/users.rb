FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest   { BCrypt::Password.create("password") }
    profile_image     { nil }
    bio               { Faker::Lorem.paragraph }
    activation_digest { nil }
    activated         { true }
    activated_at      { Time.current }
  end
end
