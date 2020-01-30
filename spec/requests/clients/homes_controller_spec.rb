# frozen_string_literal: true

require "rails_helper"

RSpec.describe Clients::HomesController, type: :request do
  include_context "travel_to_20191218_noon"
  include_context "login_by_client"

  describe "GET /clients/home" do
    it { is_expected.to eq(200) }
  end
end
