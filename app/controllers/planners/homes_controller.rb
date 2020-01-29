# frozen_string_literal: true

class Planners::HomesController < ApplicationController
  before_action :logged_in_as_planner?

  def show
    @reservations = current_planner.reservations
  end
end
