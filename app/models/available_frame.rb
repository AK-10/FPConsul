# frozen_string_literal: true

class AvailableFrame < ApplicationRecord
  belongs_to :planner
  has_one :reservation

  validates :planner, presence: true
  validates :scheduled_time, presence: true
  validates :scheduled_time, scheduled_time: true, if: :scheduled_time
  validates :planner_id, uniqueness: { scope: [:scheduled_time] }
end
