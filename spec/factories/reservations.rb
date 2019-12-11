FactoryBot.define do
  factory :reservation do
    user { build(:user) }
    planner { build(:planner) }
    description { 'this is description.' }
    scheduled_at { Time.now.change(hour: 13, min: 0) }
  end
end