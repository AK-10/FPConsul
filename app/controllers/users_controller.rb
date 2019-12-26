# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました."
      redirect_to @user
    else
      flash[:danger] = "ユーザ登録に失敗しました．"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  private
    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
      )
    end
end
