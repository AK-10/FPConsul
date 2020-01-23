# frozen_string_literal: true

require "rails_helper"

RSpec.describe AvailableFrame, type: :model do
  describe "validations" do
    around do |e|
      travel_to("2019-12-18 12:00:00") { e.run }
    end

    subject { build(:available_frame, scheduled_time: "2019-12-19 13:30:00".to_time) }

    it { is_expected.to validate_presence_of(:planner) }
    it { is_expected.to validate_presence_of(:scheduled_time) }
    it { is_expected.to validate_uniqueness_of(:planner_id).scoped_to(:scheduled_time) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:planner) }
    it { is_expected.to have_one(:reservation) }
  end
end
