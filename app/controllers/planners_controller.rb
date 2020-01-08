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
      redirect_to @planner.show_path, success: "ユーザー登録が完了しました."
    else
      flash.now[:danger] = "ユーザー登録に失敗しました."
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
