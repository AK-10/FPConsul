# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation, type: :model do
  describe "validations" do
    around do |e|
      travel_to("2019-12-18 12:00:00") { e.run }
    end

    subject { build(:reservation, scheduled_time: "2019-12-19 13:30:00".to_time) }

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:planner) }
    it { is_expected.to validate_presence_of(:scheduled_time) }
    it { is_expected.to validate_uniqueness_of(:planner).scoped_to(:scheduled_time) }

    describe "available frame of planner exist validation" do
      subject { reservation.valid? }
      let(:reservation) { build(:reservation, scheduled_time: "2019-12-19 13:30:00".to_time) }
      let(:planner) { reservation.planner }

      before { create(:available_frame, planner: planner, scheduled_time: scheduled_time) }

      context "exist available frame" do
        let(:scheduled_time) { reservation.scheduled_time }
        it { expect { subject }.not_to change { reservation.errors[:scheduled_time] } }
      end

      context "not exist available frame" do
        let(:scheduled_time) { "2019-12-19 13:00:00".to_time }
        it { expect { subject }.to change { reservation.errors[:scheduled_time] }.from([]).to(["is unavailable"]) }
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:planner) }
  end
end
