# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation, type: :model do
  around do |e|
    travel_to("2019-12-18 12:00:00") { e.run }
  end


  describe "validations" do
    it { is_expected.to validate_presence_of(:client) }
    it { is_expected.to validate_presence_of(:available_frame) }

    context "uniqueness validation" do
      include_context "reservation_have_already_created"
      it { is_expected.to validate_uniqueness_of(:available_frame) }
    end

    context "exist same time validation" do
      subject { reservation.valid? }

      context "already reserved in the time" do
        let(:client) { create(:client) }
        let(:available_frame) { create(:available_frame, scheduled_time: "2019-12-19 13:00:00") }
        let(:alt_available_frame) { create(:available_frame, scheduled_time: "2019-12-19 13:00:00") }
        let(:reservation) { build(:reservation, client: client, available_frame: available_frame) }

        before { Reservation.create(client: client, available_frame: alt_available_frame) }


        it { expect { subject }.to change { reservation.errors[:available_frame] }.from([]).to(["scheduled_time already exists"]) }
      end

      context "have not reserved not yet in the time" do
        let(:client) { create(:client) }
        let(:available_frame) { create(:available_frame, scheduled_time: "2019-12-19 13:00:00") }
        let(:reservation) { build(:reservation, client: client, available_frame: available_frame) }
        it { binding.pry }
        it { expect { subject }.not_to change { reservation.errors[:available_frame] } }
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:available_frame) }
  end
end
