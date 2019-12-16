class AvailableFrame < ApplicationRecord
  belongs_to :planner

  validates :planner, presence: true
  validates :scheduled_time, presence: true
  validates :planner_id, uniqueness: { scope: [:scheduled_time] }
end