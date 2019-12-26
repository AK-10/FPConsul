# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :request do
  describe "GET /user/join" do
    it { is_expected.to eq(200) }
  end

  describe "POST /user" do
    context "valid params" do
      let(:params) {
        {
          user: {
            name: "test2",
            email: "qwert@test.com",
            password: "qpwoei1029",
            password_confirmation: "qpwoei1029"
          }
        }
      }
      it { is_expected.to eq(302) }
    end

    context "invalid params" do
      let(:params) {
        {
          user: {
            name: "test2",
            email: "qwertterws",
            password: "qpwoei1029",
            password_confirmation: "qpwoei1029"
          }
        }
      }
      it { is_expected.to eq(400) }
    end
  end
end
