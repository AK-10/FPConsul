# frozen_string_literal: true

module AvailableFrameDecorator
  def formatted_scheduled_time
    start_time, end_time = [scheduled_time, scheduled_time + 30.minutes].map { |time| time.strftime("%H:%M") }
    scheduled_date = scheduled_time.strftime("%Y年 %m月 %d日 (%a)")
    finished = scheduled_time.past? ? "(終了)" : ""

    "#{scheduled_date} #{start_time} ~ #{end_time}#{finished}"
  end
end
