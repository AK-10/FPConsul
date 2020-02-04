# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation, type: :model do
  include_context "travel_to_20191218_noon"

  describe "validations" do
    it { is_expected.to validate_presence_of(:client) }
    it { is_expected.to validate_presence_of(:available_frame) }

    context "uniqueness validation" do
      include_context "reservation_have_already_created"
      it { is_expected.to validate_uniqueness_of(:available_frame) }
    end

    context "exist same time validation" do
      subject { reservation.valid? }

      let(:client) { create(:client) }
      let(:reservation) { build(:reservation, client: client, available_frame: available_frame) }

      context "already reserved in the time" do
        let(:available_frame) { create(:available_frame, scheduled_time: "2019-12-19 13:00:00") }
        let(:alt_available_frame) { create(:available_frame, scheduled_time: "2019-12-19 13:00:00") }

        before { create(:reservation, client: client, available_frame: alt_available_frame) }

        it { expect { subject }.to change { reservation.errors[:available_frame] }.from([]).to(["scheduled_time already exists"]) }
      end

      context "have not reserved not yet in the time" do
        let(:available_frame) { create(:available_frame, scheduled_time: "2019-12-19 13:00:00") }

        it { expect { subject }.not_to change { reservation.errors[:available_frame] } }
      end

      context "past available_frame" do
        let(:planner) { create(:planner) }
        let!(:available_frame) { create(:available_frame, planner: planner, scheduled_time: "2019-12-18 13:00:00") }

        before { travel 3.days }

        it { expect { subject }.to change { reservation.errors[:available_frame] }.from([]).to(["Scheduled time can't be past"]) }
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:available_frame) }
  end
end
