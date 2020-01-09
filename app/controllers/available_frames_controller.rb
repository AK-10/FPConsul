# frozen_string_literal: true

class AvailableFramesController < ApplicationController
  before_action :logged_in_as_planner?

  def index
    @from = (params[:from]&.to_time || Time.now).change(hour: 0, min: 0, sec: 0)
    to = @from.since(7.days)
    planner = current_planner
    @available_frames = planner.available_frames.where(scheduled_time: (@from)..(to))
  end

  def create
    planner = current_planner
    available_frame = planner.available_frames.build(available_frame_params)
    if available_frame.save
      flash[:success] = "予約枠を追加しました"
      redirect_to action: :index
    else
      flash[:danger] = "予約枠の作成に失敗しました"
      redirect_to action: :index, status: 422
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
