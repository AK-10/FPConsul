# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    client
    planner
  end
end
