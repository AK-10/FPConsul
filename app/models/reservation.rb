# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :available_frame

  validates :client, presence: true
  validates :available_frame, presence: true, uniqueness: true
  validate :other_reservation_exists_in_same_time, if: [:client, :available_frame]

  private
    def other_reservation_exists_in_same_time
      puts "called other_reservation_exists"
      presence = client.reservations.joins(:available_frame)
        .where(available_frames: { scheduled_time: available_frame.scheduled_time })
        .exists?

      errors.add(:available_frame, "scheduled_time already exists") if presence
    end
end
