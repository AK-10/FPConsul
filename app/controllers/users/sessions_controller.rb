class Users::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(session_params[:email])
    if user && user.authenticate(session_params[:password])
      redirect_to user
    else
      render :new, status: :bad_request
    end
  end

  def destroy
  end

  private

    def session_params
      params.require(:session).permit(
        :email,
        :password,
      )
    end
end