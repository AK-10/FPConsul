# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation, type: :model do
  describe "validations" do
    around do |e|
      travel_to("2019-12-11 12:00:00".to_time) { e.run }
    end

    subject { build(:reservation, scheduled_at: "2019-12-12 13:30:00".to_time) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:planner) }

    it { is_expected.to validate_presence_of(:scheduled_at) }
    it { is_expected.to validate_length_of(:description).is_at_most(200) }

    context "scheduled_at validation" do
      let(:valid_time) { "2019-12-12 12:30:00".to_time }
      let(:invalid_time) { "2019-12-12 20:30:00".to_time }
      let(:invalid_minute) { "2019-12-12 14:12:00".to_time }
      let(:invalid_time_on_saturday) { "2019-12-14 17:00:00".to_time }
      let(:sunday) { "2019-12-15 10:30:00".to_time }
      let(:past) { "2018-12-10 10:30:00".to_time }

      it { is_expected.to allow_value(valid_time).for(:scheduled_at) }
      it { is_expected.not_to allow_value(invalid_time).for(:scheduled_at) }
      it { is_expected.not_to allow_value(invalid_minute).for(:scheduled_at) }
      it { is_expected.not_to allow_value(invalid_time_on_saturday).for(:scheduled_at) }
      it { is_expected.not_to allow_value(sunday).for(:scheduled_at) }
      it { is_expected.not_to allow_value(past).for(:scheduled_at) }
    end
  end
end
