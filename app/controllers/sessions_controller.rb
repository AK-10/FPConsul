# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_to_show, only: %i(new)

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      login(user)
      flash[:info] = ["ログインしました"]
      redirect_to_show
    else
      flash.now[:alert] = ["emailまたはpasswordが間違えています．"]
      render :new, status: :unauthorized
    end
  end

  def destroy
    logout_user if logged_in?
    flash[:info] = ["ログアウトしました"]
    redirect_to login_path
  end

  private
    def session_params
      params.require(:session).permit(
        :email,
        :password,
      )
    end

    def redirect_to_show
      # インスタンスを引数に渡しても期待するpathが得られない
      # (/(clients|planners)/:id にならない)
      redirect_to current_user.show_path if logged_in?
    end

    def logout
      session.delete(:user_id)
      @current_user = nil
    end
end
