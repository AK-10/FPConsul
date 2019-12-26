class Users::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      redirect_to user
    else
      render :new, status: :bad_request
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
end