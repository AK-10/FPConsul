# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::SessionsController, type: :request do
  describe "GET /user/login" do
    it { is_expected.to eq(200) }
  end

  describe "POST /user/login" do
    context "valid params" do
      include_context "user_have_already_created"
      let(:params) {
        {
          session: {
            email: "already@created.com",
            password: "aBcDeFgHi1357",
          }
        }
      }
      it { is_expected.to eq(302) }
      it { expect(session[:user_id]).not_to eq(user.id) }
    end

    context "invalid params" do
      let(:params) {
        {
          session: {
            email: "havenot@created.com",
            password: "aBcDeFgHi1357",
          }
        }
      }
      it { is_expected.to eq(401) }
      it { expect(session[user.id]).to eq(nil) }
    end
  end

  describe "DELETE /user/logout" do
    it { is_expected.to eq(302) }
    it { expect(session[user.id]).to eq(nil) }
  end
end
