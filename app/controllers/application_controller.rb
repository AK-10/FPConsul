# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :current_planner, :current_client, :logged_in_by_user?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_client
    current_user.becomes(Client) if current_user.client?
  end

  def current_planner
    current_user.becomes(Planner) if current_user.planner?
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !!current_user
  end

  def logged_in_as_client?
    !!current_client
  end

  def logged_in_as_planner?
    !!current_planner
  end

  def require_login!
    unless logged_in?
      flash[:warning] = "ログインしてください"
      redirect_to "/user/login"
    end
  end

  def require_client_login!
    require_login!
    if logged_in_as_planner?
      flash[:warning] = "プランナーユーザのアクセスは許可されていません"
      redirect_to current_user.home_path
    end
  end

  def require_planner_login!
    require_login!
    if logged_in_as_client?
      flash[:warning] = "クライアントユーザのアクセスは許可されていません"
      redirect_to current_user.home_path
    end
  end

  def redirect_to_home
    # インスタンスを引数に渡しても期待するpathが得られない
    # (/(clients|planners)/:id にならない)
    redirect_to current_user.home_path if logged_in?
  end
end
