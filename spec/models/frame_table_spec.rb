# frozen_string_literal: true

require "rails_helper"

RSpec.describe FrameTable, type: :model do
  include_context "travel_to_20191218_noon"

  let(:planner) { build(:planner) }
  let(:start_day) { Time.current.to_date }
  let(:frames) {
    [ create(:available_frame, planner: planner, scheduled_time: "2019-12-19 13:00:00".in_time_zone),
      create(:available_frame, planner: planner, scheduled_time: "2019-12-19 13:30:00".in_time_zone),
      create(:available_frame, planner: planner, scheduled_time: "2019-12-20 11:30:00".in_time_zone),
    ]
  }

  let(:target) { FrameTable.new(frames, start_day) }

  describe "self.to_matrix" do
    context "no frames on sunday" do
      let(:sundays) { target.to_matrix.transpose[4] }
      subject { sundays.none? { |item| item.id } }
      it { expect(subject).to eq(true) }
    end

    # 予約枠は正しく入っているか
    context "confirm available_frame at correct block" do
      subject { target.to_matrix }
      it { expect(subject[6][1].id).to be_present }
      it { expect(subject[3][2].id).to be_present }
      it { expect(subject[7][1].id).to be_present }
    end

    it { expect(target.to_matrix.size).to eq(16) }
    it "is expected to 7 columns" do
      binding.pry
      expect { target.to_matrix.map { |item| p item.size; item.size == 7 }.all? }.to eq(true)

      # ERR: targetのinitializeでframesとstart_dayが渡されていない扱いになる
      # subject { target.to_matrix.map { |item| p item.size; item.size == 7 }.all? }
      # is_expected.to eq(true)
    end
  end
end
