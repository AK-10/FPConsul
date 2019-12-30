# frozen_string_literal: true

class Users::SessionsController < ApplicationController
  before_action: :logged_in?, only: %i(new)

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      login_by_user(user)
      redirect_to user
    else
      render :new, status: :unauthorized
    end
  end

  def destroy
    logout_user if logged_in_by_user?
    redirect_to login_user_path
  end

  private
    def session_params
      params.require(:session).permit(
        :email,
        :password,
      )
    end

    def logged_in?
      redirect_to current_user if logged_in_by_user?
    end
end
