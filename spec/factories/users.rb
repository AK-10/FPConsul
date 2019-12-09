FactoryBot.define do
  factory :user do
    name { '金山　太郎' }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'aBcDeFgHi1357' }
    password_confirmation { 'aBcDeFgHi1357' }
  end
end