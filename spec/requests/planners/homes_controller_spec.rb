# frozen_string_literal: true

require "rails_helper"

RSpec.describe Planners::HomesController, type: :request do
  include_context "travel_to_20191218_noon"

  let(:planner) { create(:planner) }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: planner.id })
  end

  describe "GET /planners/home" do
    it { is_expected.to eq(200) }
  end
end
