# frozen_string_literal: true

require "rails_helper"

RSpec.describe AvailableFramesController, type: :request do
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

  describe "GET /planners/:planner_id/available_frames" do
    it { is_expected.to eq(200) }
  end

  describe "POST /planners/:planner_id/available_frames" do
    context "valid params" do
      let(:params) {
        {
          available_frame: {
            scheduled_time: "2019-12-19 12:00:00"
          }
        }
      }

      it do
        is_expected.to redirect_to planner_available_frames_path(planner)
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
        is_expected.to redirect_to planner_available_frames_path(planner)
        expect(flash[:danger]).to eq(["Scheduled time can't be except 0 or 30 minutes"])
      end
    end
  end

  describe "DELETE /planners/:planner_id/available_frames/:id" do

    context "valid available_frame id" do
      let(:id) { planner.available_frames.first.id }
      it do
        is_expected.to redirect_to planner_available_frames_path(planner)
        expect(flash[:success]).to eq("予約枠を削除しました")
      end
    end

    context "unknown available_frame id" do
      let(:id) { 10000 }
      it do
        is_expected.to redirect_to planner_available_frames_path(planner)
        expect(flash[:danger]).to eq("存在しない予約枠です")
      end
    end
  end
end
