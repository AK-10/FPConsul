# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :client
  belongs_to :available_frame

  validates :client, presence: true
  validates :available_frame, presence: true, uniqueness: true
  validate :exists_same_time?

  private
    def exists_same_time?
      client.reservations.joins(:available_frame)
        .where(available_frames: { scheduled_time: available_frame.scheduled_time })
        .exists?
    end
end
