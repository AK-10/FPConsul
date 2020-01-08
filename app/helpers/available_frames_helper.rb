module AvailableFramesHelper
  def time_ranges
    first_time = Tod::TimeOfDay.new 10
    last_time = Tod::TimeOfDay.new 18
    step_min = 30.minutes
    scopes = []

    while true do
      end_time = first_time + step_min
      break if end_time > last_time

      scopes << "#{first_time.to_s} ~ #{end_time.to_s}"
      first_time = end_time
    end

    scopes
  end
end