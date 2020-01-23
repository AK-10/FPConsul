# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :available_frame

  scope :same_time_reservations, -> (time) do
    joins(:available_frame).where(available_frames: { scheduled_time: time })
  end

  validates :client, presence: true
  validates :available_frame, presence: true, uniqueness: true
  validate :other_reservation_exists_in_same_time, if: [:client, :available_frame], on: :create

  private
    def other_reservation_exists_in_same_time
      presence = client.reservations.same_time_reservations(available_frame.scheduled_time).exists?
      errors.add(:available_frame, "scheduled_time already exists") if presence
    end
end
