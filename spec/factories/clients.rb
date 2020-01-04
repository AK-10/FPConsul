# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { "田中=Client=太郎" }
    sequence(:email) { |n| "test_client#{n}@mail.example.com" }
    password { "fcilniaenncti0a2l" }
    password_confirmation { "fcilniaenncti0a2l" }
  end
end
