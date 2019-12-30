# frozen_string_literal: true

class Users::SessionsController < ApplicationController

  before_action :session_exists_filter, only: %i(new)

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

    def session_exists_filter
      redirect_to current_user if logged_in_by_user?
    end

    def login_by_user(user)
      session[:user_id] = user.id
    end

    def logout_user
      session.delete(:user_id)
      @current_user = nil
    end
end
