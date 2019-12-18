class Reservation < ApplicationRecord
  belongs_to :planner
  belongs_to :user

  validates :planner, presence: true
  validates :user, presence: true
  validates :scheduled_time, presence: true
  validates :scheduled_time, scheduled_time: true, if: :scheduled_time
  validate :validate_available_frame_exists, if: [:planner, :scheduled_time]
  validates :planner_id, uniqueness: { scope: [:scheduled_time] }

  private
    def validate_available_frame_exists
      frame_exists = planner.available_frames.where(scheduled_time: scheduled_time).exists?
      return if frame_exists

      errors.add(:scheduled_time, 'is unavailable')
    end
end
