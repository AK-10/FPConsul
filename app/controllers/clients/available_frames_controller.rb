# frozen_string_literal: true

class Clients::AvailableFramesController < ApplicationController
  before_action :logged_in_as_client?

  def index
    @from = (params[:from]&.in_time_zone || Time.current).change(hour: 0, min: 0, sec: 0)
    @to = @from.since(7.days)
    @available_frames = AvailableFrame.where(scheduled_time: (@from)..(@to))
  end
end
