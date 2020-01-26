# frozen_string_literal: true

class AvailableFrame < ApplicationRecord
  scope :not_reserved, -> do
    eager_load(:reservation)
      .where(reservations: { available_frame_id: nil })
  end

  before_destroy :prevent_destroy_if_reservation_exist

  belongs_to :planner
  has_one :reservation, dependent: :destroy

  validates :planner, presence: true
  validates :scheduled_time, presence: true
  validates :scheduled_time, scheduled_time: true, if: :scheduled_time
  validates :planner_id, uniqueness: { scope: [:scheduled_time] }

  private
    def prevent_destroy_if_reservation_exist
      if reservation
        errors.add(:this, "is already reserved by client")
        throw :abort
      end
    end
end
