# frozen_string_literal: true

class Clients::ReservationsController < ApplicationController
  before_action :client_login_required
  before_action :redirect_unless_datetime_params, only: %i(new)

  def new
    datetime = params[:datetime]
    @available_frames = AvailableFrame.available.where(scheduled_time: datetime)
  end

  def create
    reservation = current_client.reservations.build(reservation_params)
    if reservation.save
      reserved_time = reservation.available_frame.scheduled_time.strftime("%Y年 %m月 %d日 (%a) %T")
      flash[:success] = "予約しました(#{reserved_time})"
    else
      flash.now[:danger] = reservation.errors.full_messages
    end

    redirect_to clients_available_frames_path(current_client)
  end

  def destroy
    reservation = current_client.reservations.find(params[:id])
    reservation.destroy!
    flash[:success] = "予約を削除しました"
  rescue ActiveRecord::RecordNotFound
    flash.now[:danger] = "存在しない予約です"
  rescue ActiveRecord::RecordNotDestroyed => err
    flash.now[:danger] = err.record.errors.full_messages
  ensure
    redirect_to clients_home_path
  end

  private
    def reservation_params
      params.require(:reservation).permit(
        :available_frame_id
      )
    end

    def redirect_unless_datetime_params
      return if params[:datetime]

      flash[:danger] = "時間が指定されていません"
      redirect_to clients_available_frames_path(current_client)
    end
end
