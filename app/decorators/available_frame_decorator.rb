# frozen_string_literal: true

module AvailableFrameDecorator
  def formatted_scheduled_time
    # start_time = scheduled_time.strftime("%H:%M")
    # end_time = (scheduled_time + 30.minutes).strftime("%H:%M") # 略しすぎ？
    # scheduled_date = scheduled_time.strftime("%Y年 %m月 %d日 (%a)")

    start_time = scheduled_time
    end_time = scheduled_time + 30.minutes

    scheduled_date_format_string = scheduled_time.strftime("%Y年 %m月 %d日 (%a)")
    start_time_format_string = start_time.strftime("%H:%M")
    end_time_format_string = end_time.strftime("%H:%M")

    "#{scheduled_date_format_string} #{start_time_format_string} #{end_time_format_string}"
  end
end
