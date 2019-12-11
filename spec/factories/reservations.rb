FactoryBot.define do
  factory :reservation do
    user { create(:user) }
    planner { create(:planner) }
    description { 'this is description.' }
  end
end