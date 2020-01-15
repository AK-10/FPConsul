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
    ]
  }

  let(:target) { FrameTable.generate_matrix(frames, start_day) }

  describe "self.generate_matrix" do
    context "no frames on sunday" do
      let(:sundays) { target.transpose[4]}
      subject { sundays.reduce(true) { |acc, item| acc && !item.is_available } }
      it { expect(subject).to eq(true) }
    end

    # 予約枠は正しく入っているか
    context "confirm available_frame at correct block" do
      it { expect(target[6][1].is_available).to eq(true) }
      it { expect(target[7][1].is_available).to eq(true) }
      it { expect(target[4][2].is_available).to eq(true) }
    end
  end
end