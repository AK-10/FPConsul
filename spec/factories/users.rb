FactoryBot.define do
  factory :user do
    name { '金山　太郎' }
    email { 'test@example.com' }
    password { 'aBcDeFgHi' }
    password_confirmation { 'aBcDeFgHi' }
  end
end