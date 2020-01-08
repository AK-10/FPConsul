class AvailableFramesController < ApplicationController

  def index
    from = (params[:from]&.to_time || Time.now).change(hour: 0, min: 0, sec: 0)
    to = from.since(7.days)
    @client = current_user.convert_class_with_user_type
    @available_frames = client.available_frames.where(scheduled_time: (from)..(to))
  end

  def create
    planner = current_user.convert_class_with_user_type
    available_frame = planner.available_frames.build(available_frame_params)
    if available_frame.save
      flash[:success] = "予約枠を追加しました"
      redirect_to :index
    else
      flash[:danger] = "予約枠の作成に失敗しました"
      redirect_to :index
    end
  end

  def destroy
  end

  private
    def available_frame_params
      params.require(:available_frame).permit(
        :scheduled_time
      )
    end
end
