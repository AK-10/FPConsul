module Users
  module SessionsHelper
    def login_by_user(user)
      session[:user_id] = user.id
    end

    def logout_by_user
      session.delete(:user_id)
    end
  end
end