class Clients::ReservationsController < ApplicationController
  before_action :logged_in_as_client?
  
  def new
    datetime = params[:datetime]
    unless datetime
      flash[:danger] = ["時間が指定されていません"]
      redirect_to client_available_frames(current_client)
    end
    @available_frames = AvailableFrame.not_reserved.where(scheduled_time: datetime)
  end
end