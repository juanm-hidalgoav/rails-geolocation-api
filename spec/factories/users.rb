FactoryBot.define do
  factory :user do
    email { "testuser@example.com" }
    encrypted_password { "122wd32t43r" }
  end
end