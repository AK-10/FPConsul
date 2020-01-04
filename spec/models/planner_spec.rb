# frozen_string_literal: true

require "rails_helper"

RSpec.describe Planner, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:available_frames).dependent(:destroy) }
    it { is_expected.to have_many(:reservations).dependent(:destroy) }
  end
end
