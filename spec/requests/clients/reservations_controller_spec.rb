# frozen_string_literal: true

require "rails_helper"

RSpec.describe Clients::ReservationsController, type: :request do
  include_context "travel_to_20191218_noon"

  let(:client) { create(:client) }
  let(:client_id) { client.id }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: client_id })
  end

  describe "GET /clients/reservations/new" do
    context "contains datetime parameter" do
      let(:params) {
        { datetime: "2019-12-19 12:00:00" }
      }

      it { is_expected.to eq(200) }
    end

    context "not contain datetime parameter" do
      it "is expected to fail to get available_frames" do
        is_expected.to redirect_to clients_available_frames_path
        expect(flash[:danger]).to eq("時間が指定されていません")
      end
    end
  end

  describe "POST /clients/reservations" do
    context "available_frame exist" do
      let(:planner) { create(:planner) }
      let(:available_frame) { planner.available_frames.create(scheduled_time: "2019-12-18 13:00:00") }

      let(:params) do
        {
          reservation: {
            available_frame_id: available_frame.id
          }
        }
      end

      it "is expected to success reserving" do
        is_expected.to redirect_to clients_available_frames_path
        expect(flash[:success]).to eq("予約しました(#{available_frame.scheduled_time.strftime("%Y年 %m月 %d日 (%a) %T")})")
      end
    end

    context "available_frame not exist" do
      let(:available_frame_id) { (AvailableFrame.last&.id || 1) + 100 }

      let(:params) do
        {
          reservation: {
            available_frame_id: available_frame_id
          }
        }
      end

      it "is expected to fail reserving" do
        is_expected.to redirect_to clients_available_frames_path
        expect(flash[:danger]).to eq(["Available frame must exist", "Available frame can't be blank"])
      end
    end

    context "other reservation exists in same time" do
      # 同じ時間のavailable_frameを2つ作る
      # 一つのclientで二つとも予約しようとする
      before do
        planner = create(:planner)
        available_frame = create(:available_frame, planner: planner, scheduled_time: "2019-12-18 13:00:00")
        create(:reservation, available_frame: available_frame, client: client)
      end

      let(:planner) { create(:planner) }
      let(:available_frame) { planner.available_frames.create(scheduled_time: "2019-12-18 13:00:00") }

      let(:params) do
        {
          reservation: {
            available_frame_id: available_frame.id
          }
        }
      end

      it "is expected to fail reserving" do
        is_expected.to redirect_to clients_available_frames_path
        expect(flash[:danger]).to eq(["Available frame scheduled_time already exists"])
      end
    end

    context "past available_frame" do
      let(:planner) { create(:planner) }
      let!(:available_frame) { create(:available_frame, planner: planner, scheduled_time: "2019-12-18 13:00:00") }

      before { travel 3.days }
      let(:params) do
        {
          reservation: {
            available_frame_id: available_frame.id
          }
        }
      end

      it "is expected to fail because of past available_frame" do
        is_expected.to redirect_to clients_available_frames_path
        expect(flash[:danger]).to eq(["Available frame 過去の予約枠は選択できません"])
      end
    end
  end

  describe "DELETE /clients/reservations/:reservation_id" do
    context "valid reservation id" do
      let(:planner) { create(:planner) }
      let(:available_frame) { create(:available_frame, planner: planner, scheduled_time: "2019-12-18 13:00:00") }
      let(:reservation) { create(:reservation, client: client, available_frame: available_frame) }
      let(:reservation_id) { reservation.id }

      it "is expected to success" do
        is_expected.to redirect_to clients_home_path
        expect(flash[:success]).to eq("予約を削除しました")
      end
    end

    context "unkown reservation id" do
      let(:reservation_id) { (Reservation.last&.id || 1) + 100 }

      it "is expected to fail because reservation not found" do
        is_expected.to redirect_to clients_home_path
        expect(flash[:danger]).to eq("存在しない予約です")
      end
    end
  end
end
