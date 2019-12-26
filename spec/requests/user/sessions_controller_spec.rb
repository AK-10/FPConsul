# frozen_string_literal: true

require "rails_helper"

RSpec.describe User::SessionsController, type: :request do
  describe "GET /user/login" do
    it { is_expected.to eq(200) }
  end

  describe "POST /user/login" do
    context "valid params" do
      let(:params) {
        {
          session: {
            email: "qwert@test.com",
            password: "qpwoei1029",
          }
        }
      }
      it { is_expected.to eq(302) }
    end

    context "invalid params" do
      let(:params) {
        {
          user: {
            email: "qwertterws",
            password: "qpwoei1029",
          }
        }
      }
      it { is_expected.to eq(401) }
    end
  end

  describe "DELETE /user/logout" do
    it { is_expected.to eq(200) }
  end
end
