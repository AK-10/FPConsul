# frozen_string_literal: true

require "rails_helper"

RSpec.describe AvailableFramesController, type: :request do
  let(:planner) { create(:planner) }
  let(:planner_id) { planner.id }

  around do |e|
    travel_to("2019-12-18 12:00:00") { e.run }
  end

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: planner.id })
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
        is_expected.to eq(302)
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
        is_expected.to eq(422)
        expect(flash[:danger]).to eq("予約枠の作成に失敗しました")
      end
    end
  end
end
