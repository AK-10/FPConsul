# frozen_string_literal: true

class PlannersController < ApplicationController
  def new
    @planner = Planner.new
  end

  def show
  end

  def create
    @planner = Planner.new(planner_params)
    if @planner.save
      login(@planner)
      flash[:success] = "ユーザー登録が完了しました."
      redirect_to planners_home_path(@planner)
    else
      flash.now[:danger] = @planner.errors.full_messages
      render :new, status: :unprocessable_entity
    end
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
