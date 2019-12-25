# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Users::SessionsHelper
end
