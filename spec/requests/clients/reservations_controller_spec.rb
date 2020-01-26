# frozen_string_literal: true

require "rails_helper"

RSpec.describe Clients::AvailableFramesController, type: :request do
  include_context "travel_to_20191218_noon"

  let(:client) { create(:client) }
  let(:client_id) { client.id }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: client_id })
  end

  describe "GET /clients/:client_id/reservations/new" do
    context "contains datetime parameter" do
      let(:params) {
        { datetime: "2019-12-19 12:00:00" }
      }

      it { is_expected.to eq(200) }
    end

    context "not contain datetime parameter" do
      it do
        is_expected.to redirect_to client_available_frames_path(client)
        expect(flash[:danger]).to eq(["時間が指定されていません"])
      end
    end
  end
end
