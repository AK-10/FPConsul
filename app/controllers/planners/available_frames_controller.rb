# frozen_string_literal: true

class Planners::AvailableFramesController < ApplicationController
  include PlannerConcern

  before_action :require_planner_login!

  def index
    start_time = (params[:from]&.in_time_zone || Time.current) rescue Time.current

    @scheduled_time_from = start_time.beginning_of_day
    @scheduled_time_to = @scheduled_time_from.since(7.days)

    @available_frames = current_planner.available_frames.where(scheduled_time: (@scheduled_time_from)..(@scheduled_time_to))
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
    available_frame = current_planner.available_frames.find(params[:id])
    available_frame.destroy!
    flash[:success] = "予約枠を削除しました"
  rescue ActiveRecord::RecordNotFound
    flash.now[:danger] = "存在しない予約枠です"
  rescue ActiveRecord::RecordNotDestroyed => err
    flash.now[:danger] = err.record.errors.full_messages
  ensure
    redirect_to action: :index
  end

  private
    def available_frame_params
      params.require(:available_frame).permit(
        :scheduled_time
      )
    end
end
