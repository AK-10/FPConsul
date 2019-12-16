class AvailableFrame < ApplicationRecord
  belongs_to :planner

  validates :planner, presence: true
  validates :date_time, presence: true
  validates :planner_id, uniqueness: { scope: [:date_time] }

end