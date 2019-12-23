class UsersController < ApplicationController
  def new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー登録が完了しました.'
      redirect_to @user
    else
      flash[:danger] = 'ユーザ登録に失敗しました．'
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

    def user_params
      param.fetch(:user, {}).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
      )
    end
end
