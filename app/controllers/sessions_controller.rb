# frozen_string_literal: true

class SessionsController < ApplicationController
  include SessionConcern

  before_action :redirect_to_home, only: %i(new)

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      login(user)
      flash[:info] = "ログインしました"
      redirect_to_home
    else
      flash.now[:alert] = "emailまたはpasswordが間違えています．"
      render :new, status: :unauthorized
    end
  end

  def destroy
    logout if logged_in?
    flash[:info] = "ログアウトしました"
    redirect_to login_path
  end

  private
    def session_params
      params.require(:session).permit(
        :email,
        :password,
      )
    end

    def logout
      session.delete(:user_id)
      @current_user = nil
    end
end
