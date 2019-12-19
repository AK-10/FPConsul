# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    user
    planner
  end
end
