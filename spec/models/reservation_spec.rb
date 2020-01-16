# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation, type: :model do
  describe "validations" do
    
    it { is_expected.to validate_presence_of(:client) }
    it { is_expected.to validate_presence_of(:available_frame) }
    
    context "uniqueness validation" do
      around do |e|
        travel_to("2019-12-18 12:00:00") { e.run }
      end


      include_context "reservation_have_already_created"
      it { is_expected.to validate_uniqueness_of(:available_frame) }
      it { is_expected.to validate_uniqueness_of(:client_id).scoped_to(:available_frame_id) }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:available_frame) }
  end
end
