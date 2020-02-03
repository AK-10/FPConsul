class TopController < ApplicationController
  include SessionConcern
  before_action :redirect_to_home, only: :show
  def show
  end
end
