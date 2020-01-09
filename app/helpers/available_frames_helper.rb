# frozen_string_literal: true

module AvailableFramesHelper
  def start_times
    first_time = Tod::TimeOfDay.new(10)
    last_time = Tod::TimeOfDay.new(17, 30)
    step_min = 30.minutes

    Tod::Shift.new(first_time, last_time)
      .range
      .step(step_min)
      .map { |t| Tod::TimeOfDay.from_second_of_day(t) }
  end

  def time_ranges
    step_min = 30.minutes
    start_times.map do |start_time|
      end_time = start_time + step_min
      "#{start_time} ~ #{end_time}"
    end
  end

  # framesはplannerがstart_dayから7日間の有効な予約枠のリスト
  # 一週間の予約枠を取得する．　表示にテーブルを用いているので 16 * 7の二次元配列を作る
  def normalized_frames(frames, start_day)
    # ベースとなる値の配列を作成
    # 予約可能枠を当てはめる必要があるため,いきなり二次元配列にしない(二次元配列にすると探索が面倒)
    base_cells= start_times.flat_map do |start_time|
      date_range(start_day).map do |day|
        OpenStruct.new(datetime: start_time.on(day), time: start_time, is_available: false)
      end
    end

    # plannerが設定した予約枠を入れ込む
    frames.each do |frame|
      cell = base_cells.find { |element| frame.scheduled_time == element.datetime }
      cell.is_available = true
    end

    # timeでグループ化し，valuesをとることで二次元配列にする
    base_cells.group_by { |cell| cell.time }.values
  end

  def time_tables(frames, start_day)
    time_ranges.zip(normalized_frames(frames, start_day))
  end

  def date_range(day)
    day..day.since(7.days)
  end
end
