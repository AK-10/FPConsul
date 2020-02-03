# frozen_string_literal: true

module ClientConcern
  extend ActiveSupport::Concern
  include SessionConcern

  included do
    helper_method :current_client
  end

  def current_client
    current_user.becomes(Client) if current_user.client?
  end

  def logged_in_as_client?
    !!current_client
  end

  def require_client_login!
    require_login!
    unless logged_in_as_client?
      flash[:warning] = "クライアントユーザ以外のアクセスは許可されていません"
      redirect_to current_user.home_path
    end
  end
end
