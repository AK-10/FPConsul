# frozen_string_literal: true

require "rails_helper"

RSpec.describe Planners::AvailableFramesController, type: :request do
  include_context "travel_to_20191218_noon"

  let(:planner) do
    create(:planner) do |planner|
      planner.available_frames.create(scheduled_time: "2019-12-18 13:00:00")
    end
  end
  let(:planner_id) { planner.id }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: planner_id })
  end

  describe "GET /planners/available_frames" do
    it { is_expected.to eq(200) }
  end

  describe "POST /planners/available_frames" do
    context "valid params" do
      let(:params) {
        {
          available_frame: {
            scheduled_time: "2019-12-19 12:00:00"
          }
        }
      }

      it do
        is_expected.to redirect_to planners_available_frames_path
        expect(flash[:success]).to eq("予約枠を追加しました")
      end
    end

    context "invalid params" do
      let(:params) {
        {
          available_frame: {
            scheduled_time: "2019-12-19 12:12:00"
          }
        }
      }

      it do
        is_expected.to redirect_to planners_available_frames_path
        expect(flash[:danger]).to eq(["Scheduled time can't be except 0 or 30 minutes"])
      end
    end
  end

  describe "DELETE /planners/available_frames/:available_frame_id" do
    context "valid available_frame id" do
      let(:available_frame_id) { planner.available_frames.first.id }
      it "is expected to success" do
        is_expected.to redirect_to planners_available_frames_path
        expect(flash[:success]).to eq("予約枠を削除しました")
      end
    end

    context "available_frame which fail destroy validation" do
      let(:available_frame_id) { planner.available_frames.first.id }
      let(:client) { create(:client) }
      before { create(:reservation, client: client, available_frame_id: available_frame_id) }

      it "is expected to fail because already reserved" do
        is_expected.to redirect_to planners_available_frames_path
        expect(flash[:danger]).to eq(["This is already reserved by client"])
      end
    end

    context "unknown available_frame id" do
      let(:available_frame_id) { AvailableFrame.last.id + 100 }
      it "is expected to fail because available_frame is gone" do
        is_expected.to redirect_to planners_available_frames_path
        expect(flash[:danger]).to eq("存在しない予約枠です")
      end
    end
  end
end
