class Clients::ReservationsController < ApplicationController
  before_action :logged_in_as_client?

  def new
    datetime = params[:datetime]
    unless datetime
      flash[:danger] = ["時間が指定されていません"]
      redirect_to client_available_frames_path(current_client)
    end

    @available_frames = AvailableFrame.not_reserved.where(scheduled_time: datetime)
  end

  def create
    reservation = current_client.reservations.build(reservation_param)
    if reservation.save
      time = reservation.available_frame.scheduled_time
      flash[:success] = ["予約しました(#{time.strftime("%Y年 %m月 %d日 (%a) %T")})"]
    else
      flash.now[:danger] = reservation.errors.full_messages
    end

    redirect_to client_available_frames_path(current_client)
  end

  def destroy
  end

  private
    def reservation_params
      params.require(:reservation).permit(
        :available_frame_id
      )
    end
end
