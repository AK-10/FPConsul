# frozen_string_literal: true

module AvailableFramesHelper
  delegate :date_range, to: FrameTable

  def time_ranges
    step_min = 30.minutes
    FrameTable.start_times.map do |start_time|
      end_time = start_time + step_min
      "#{start_time} ~ #{end_time}"
    end
  end

  def time_table(frames, start_day)
    table_matrix = FrameTable.generate_matrix(frames, start_day)
    time_ranges.zip(table_matrix)
  end
end
