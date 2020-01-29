# frozen_string_literal: true

require "rails_helper"

RSpec.describe Clients::HomesController, type: :request do
  include_context "travel_to_20191218_noon"

  let(:client) { create(:client) }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: client.id })
  end

  describe "GET /clients/home" do
    it { is_expected.to eq(200) }
  end
end
