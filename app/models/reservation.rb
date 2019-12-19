class Reservation < ApplicationRecord
  belongs_to :planner
  belongs_to :user

  validates :user, presence: true
  validates :planner, presence: true, uniqueness: { scope: [:scheduled_time] }
  validates :scheduled_time, presence: true
  validates :scheduled_time, scheduled_time: true, if: :scheduled_time
  validate :validate_available_frame_exists, if: [:planner, :scheduled_time]

  private
    def validate_available_frame_exists
      return if planner.available_frames.where(scheduled_time: scheduled_time).exists?
      errors.add(:scheduled_time, 'is unavailable')
    end
end
