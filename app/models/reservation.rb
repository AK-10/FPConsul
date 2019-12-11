# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :planner

  validates :description, length: { maximum: 200 }
  validates :scheduled_at, presence: true
  validate :validate_scheduled_at

  private

  def validate_scheduled_at
    minuite = scheduled_at.min

    errors.add(:scheduled_at, "can't be except 0, 30") if minuite % 30 != 0

    start_time = scheduled_at.change(hour: 10, min: 0)
    end_time = scheduled_at.change(hour: 17, min: 30)
    unless scheduled_at.between?(start_time, end_time)
      errors.add(:scheduled_at, "can't be except 10:00 - 18:00")
    end

    start_time = scheduled_at.change(hour: 11, min: 0)
    end_time = scheduled_at.change(hour: 14, min: 30)
    if scheduled_at.saturday? && !scheduled_at.between?(start_time, end_time)
      errors.add(:scheduled_at, "can't be except 11:00 - 15:00 on saturday")
    end

    errors.add(:scheduled_at, "can't be sunday") if scheduled_at.sunday?

    errors.add(:scheduled_at, "can't be past") if scheduled_at.past?
  end
end
