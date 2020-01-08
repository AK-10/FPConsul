# frozen_string_literal: true

class ClientsController < ApplicationController
  def new
    @client= Client.new
  end

  def show
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      login(@client)
      redirect_to @client.show_path, success: "ユーザー登録が完了しました."
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
    def client_params
      params.require(:client).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
      )
    end
end
