# frozen_string_literal: true

class Planners::HomesController < ApplicationController
  before_action :planner_login_required

  def show
    @reservations = current_planner.reservations
                      .joins([:available_frame, :client])
                      .eager_load([:available_frame, :client])
  end
end
