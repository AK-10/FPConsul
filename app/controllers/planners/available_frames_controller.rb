# frozen_string_literal: true

class Planners::AvailableFramesController < ApplicationController
  before_action :logged_in_as_planner?

  def index
    @from = (params[:from]&.in_time_zone || Time.current).change(hour: 0, min: 0, sec: 0)
    to = @from.since(7.days)
    @available_frames = current_planner.available_frames.where(scheduled_time: (@from)..(to))
  end

  def create
    available_frame = current_planner.available_frames.build(available_frame_params)
    if available_frame.save
      flash[:success] = "予約枠を追加しました"
    else
      flash[:danger] = available_frame.errors.full_messages
    end
    redirect_to action: :index
  end

  def destroy
    begin
      available_frame = current_planner.available_frames.find(params[:id])
      available_frame.destroy!
      flash[:success] = "予約枠を削除しました"
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "存在しない予約枠です"
    rescue ActiveRecord::RecordNotDestroyed => err
      flash[:danger] = err.record.errors.full_messages
    end
    redirect_to action: :index
  end

  private
    def available_frame_params
      params.require(:available_frame).permit(
        :scheduled_time
      )
    end
end
