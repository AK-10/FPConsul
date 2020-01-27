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

  describe "POST /clients/:client_id/reservations" do
    context "available_frame exist" do
      let(:planner) { create(:planner) }
      let(:available_frame) { planner.available_frames.create(scheduled_time: "2019-12-18 13:00:00") }

      let(:params) {
        {
          reservation: {
            available_frame_id: available_frame.id
          }
        }
      }

      it do
        is_expected.to redirect_to client_available_frames_path(client)
        expect(flash[:success]).to eq(["予約しました(#{available_frame.scheduled_time.strftime("%Y年 %m月 %d日 (%a) %T")})"])
      end
    end

    context "available_frame not exist" do
      let(:available_frame_id) do
        AvailableFrame.last&.id || 1
      end
      let(:params) {
        {
          reservation: {
            available_frame_id: available_frame_id
          }
        }
      }

      it do
        is_expected.to redirect_to client_available_frames_path(client)
        expect(flash[:danger]).to eq(["Available frame must exist", "Available frame can't be blank"])
      end
    end

    context "other reservation exists in same time" do
      # 同じ時間のavailable_frameを2つ作る
      # 一つのclientで二つとも予約しようとする
      before do
        create(:planner) do |planner|
          af = create(:available_frame, planner: planner, scheduled_time: "2019-12-18 13:00:00")
          create(:reservation, available_frame: af, client: client)
        end
      end

      let(:planner) { create(:planner) }
      let(:available_frame) { planner.available_frames.create(scheduled_time: "2019-12-18 13:00:00") }

      let(:params) {
        {
          reservation: {
            available_frame_id: available_frame.id
          }
        }
      }

      it do
        is_expected.to redirect_to client_available_frames_path(client)
        expect(flash[:danger]).to eq(["Available frame scheduled_time already exists"])
      end
    end
  end
end
