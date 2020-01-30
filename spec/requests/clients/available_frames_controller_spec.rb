# frozen_string_literal: true

require "rails_helper"

RSpec.describe Clients::AvailableFramesController, type: :request do
  let(:client) { create(:client) }
  let(:client_id) { client.id }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: client_id })
  end

  describe "GET /clients/available_frames" do
    it { is_expected.to eq(200) }
  end
end
