# frozen_string_literal: true

module PlannerConcern
  extend ActiveSupport::Concern
  include SessionConcern

  included do
    helper_method :current_planner

    def current_planner
      current_user.becomes(Planner) if current_user.planner?
    end

    def logged_in_as_planner?
      !!current_planner
    end

    def require_planner_login!
      require_login!
      unless logged_in_as_planner?
        flash[:warning] = "プランナーユーザ以外のアクセスは許可されていません"
        redirect_to current_user.home_path
      end
    end
  end
end
