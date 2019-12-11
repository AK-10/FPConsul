# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :planner

  validates :description, length: { maximum: 200 }
  validates :scheduled_at, presence: true
  validate :validate_time_range, :validate_time_range_on_saturday, :validate_sunday, :validate_past

  private

  def validate_time_range
    start_time = scheduled_at.change(hour: 10, min: 0)
    end_time = scheduled_at.change(hour: 17, min: 30)
    unless scheduled_at.between?(start_time, end_time)
      errors.add(:scheduled_at, "can't be except 10:00 - 18:00")
    end
  end

  def validate_time_range_on_saturday
    start_time = scheduled_at.change(hour: 11, min: 0)
    end_time = scheduled_at.change(hour: 14, min: 30)
    if scheduled_at.saturday? && !scheduled_at.between?(start_time, end_time)
      errors.add(:scheduled_at, "can't be except 11:00 - 15:00 on saturday")
    end
  end

  def validate_minutes
    minutes = scheduled_at.min
    errors.add(:scheduled_at, "can't be except 0, 30") if minutes % 30 != 0
  end

  def validate_sunday
    errors.add(:scheduled_at, "can't be sunday") if scheduled_at.sunday?
  end

  def validate_past
    errors.add(:scheduled_at, "can't be past") if scheduled_at.past?
  end
end
