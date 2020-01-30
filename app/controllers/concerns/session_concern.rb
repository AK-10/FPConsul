# frozen_string_literal: true

module SessionConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :logged_in?

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def login(user)
      session[:user_id] = user.id
    end

    def logged_in?
      !!current_user
    end

    def require_login!
      unless logged_in?
        flash[:warning] = "ログインしてください"
        redirect_to "/user/login"
      end
    end

    def redirect_to_home
      # インスタンスを引数に渡しても期待するpathが得られない
      # (/(clients|planners)/:id にならない)
      redirect_to current_user.home_path if logged_in?
    end
  end
end
