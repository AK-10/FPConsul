# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :available_frame

  validates :client, presence: true
  validates :available_frame, presence: true, unique: true
  validates :client_id, uniqueness: { scope: [:available_frame_id] }

  private
    def validate_available_frame_exists
      return if planner.available_frames.where(scheduled_time: scheduled_time).exists?
      errors.add(:scheduled_time, "is unavailable")
    end
end
