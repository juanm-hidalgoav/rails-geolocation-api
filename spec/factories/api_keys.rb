FactoryBot.define do
  factory :api_key do
    association :user
    key { SecureRandom.hex(32) }
    description { "Test API Key" }
  end
end