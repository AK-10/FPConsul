# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in_by_user?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_in_as_client?
    logged_in? && current_user.client?
  end

  def logged_in_as_planner?
    logged_in? && current_user.planner?
  end

  # User.user_types.keys.map { |key| [key, "logged_in_as_#{key}?".to_sym] }.each do |type, sym|
  #   define_method(sym) do
  #     logged_in? && eval("current_user.#{type}?")
  #   end
  # end
end
