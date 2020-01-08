module AvailableFramesHelper

  def start_times
    start_time = Tod::TimeOfDay.new(10)
    last_time = Tod::TimeOfDay.new(17, 30)
    step_min = 30.minutes
    times = []

    while true do
      break if start_time > last_time
      times << start_time

      start_time += step_min
    end

    times
  end

  def time_ranges
    step_min = 30.minutes
    start_times.map do |start_time|
      end_time = start_time + step_min
      "#{start_time.to_s} ~ #{end_time.to_s}"
    end
  end

  def normalized_frames(frames)
    frames
  end

  def time_tables(frames)
    time_ranges.zip(normalized_frames(frames))
  end

  def date_range(day)
    day..day.since(7.days)
  end
end