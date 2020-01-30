# frozen_string_literal: true

class Clients::HomesController < ApplicationController
  before_action :require_client_login!

  def show
    @reservations = current_client.reservations
                      .joins(available_frame: :planner)
                      .eager_load(available_frame: :planner)
  end
end
