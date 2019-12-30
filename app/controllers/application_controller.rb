# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in_by_user?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in_by_user?
    !current_user.nil?
  end
end
