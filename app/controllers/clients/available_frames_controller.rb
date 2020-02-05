# frozen_string_literal: true

class Clients::AvailableFramesController < ApplicationController
  include ClientConcern

  before_action :require_client_login!

  def index
    start_time = (params[:from]&.in_time_zone || Time.current) rescue Time.current

    @scheduled_time_from = start_time.beginning_of_day
    @scheduled_time_to = @scheduled_time_from.since(7.days)

    @available_frames = AvailableFrame.available.where(scheduled_time: (@scheduled_time_from)..(@scheduled_time_to))
  end
end
