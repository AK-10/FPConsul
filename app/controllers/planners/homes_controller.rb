# frozen_string_literal: true

class Planners::HomesController < ApplicationController
  before_action :require_planner_login!

  def show
    @reservations = current_planner.reservations
                      .joins([:available_frame, :client])
                      .eager_load([:available_frame, :client])
  end
end
