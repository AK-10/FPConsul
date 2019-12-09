FactoryBot.define do
  factory :planner do
    name { 田中=FP=太郎 }
    sequence(:email) { |n| "test_fp#{n}@mail.example.com" }
    password { 'fpilnaannecri0a2l' }
    password_confirmation { 'fpilnaannecri0a2l' }
  end
end