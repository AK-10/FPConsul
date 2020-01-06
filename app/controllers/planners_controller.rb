class PlannersController < ApplicationController

  def index
  end

  def new
    @planner = Planner.new
  end

  def create
    @planner = Planner.new(planner_params)
  end

  def edit
  end

  def update
  end

  private
    def planner_params
      params.require(:planner).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
      )
    end

end
