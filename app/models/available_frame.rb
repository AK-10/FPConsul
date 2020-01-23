# frozen_string_literal: true

class AvailableFrame < ApplicationRecord
  before_destroy do
    if reservation
      errors.add(:this, "is already reserved")
      throw :abort
    end
  end

  belongs_to :planner
  has_one :reservation, dependent: :destroy

  validates :planner, presence: true
  validates :scheduled_time, presence: true
  validates :scheduled_time, scheduled_time: true, if: :scheduled_time
  validates :planner_id, uniqueness: { scope: [:scheduled_time] }
end
