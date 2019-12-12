FactoryBot.define do
  factory :reservation do
    description { 'this is description.' }
    user
    planner
  end
end