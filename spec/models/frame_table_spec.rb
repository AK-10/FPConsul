require "rails_helper"

RSpec.describe FrameTable, type: :model do
  around do |e|
    travel_to("2019-12-18 12:00:00") { e.run }
  end

  let(:planner) { build(:planner) }
  let(:start_day) { Time.current.to_date }
  let(:frames) { 
    [ build(:available_frame, planner: planner, scheduled_time: "2019-12-19 13:00:00".in_time_zone),
      build(:available_frame, planner: planner, scheduled_time: "2019-12-19 13:30:00".in_time_zone),
      build(:available_frame, planner: planner, scheduled_time: "2019-12-20 11:30:00".in_time_zone),
      build(:available_frame, planner: planner, scheduled_time: "2019-12-20 13:30:00".in_time_zone),
      build(:available_frame, planner: planner, scheduled_time: "2019-12-22 11:30:00".in_time_zone),
      build(:available_frame, planner: planner, scheduled_time: "2019-12-22 14:30:00".in_time_zone),
    ]
  }


  describe "self.generate_matrix" do
    # 何をすればいいんだ？
    context "no frames on sunday" do
      let(:target) { FrameTable.generate_matrix(frames, start_day) }
      let(:sundays) { target.transpose[4].reduce(true) { |acc, item| acc && !item.is_available } }
      subject { sundays }
      it { expect(subject).to eq(true) }
    end

    # 予約枠は正しく入っているか
    context "confirm available_frame at correct block"
    it { expect(target[0][6]).to eq(frames.first) }
    it { expect(target[0][7]).to eq(frames.second) }
  end
end