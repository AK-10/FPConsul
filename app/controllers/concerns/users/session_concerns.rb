module Users
  module SessionConcerns
    def login_by_user(user)
      session[:user_id] = user.id
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in_by_user?
      !current_user.nil?
    end

    def logout_user
      session.delete(:user_id)
      @current_user = nil
    end
  end
end
