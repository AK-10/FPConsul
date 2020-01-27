# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :request do
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

      it do
        is_expected.to eq(302)
        expect(flash[:info]).to eq("ログインしました")
      end
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

      it do
        is_expected.to eq(401)
        expect(flash[:alert]).to eq("emailまたはpasswordが間違えています．")
      end
    end
  end

  describe "DELETE /user/logout" do
    it do
      is_expected.to eq(302)
      expect(flash[:info]).to eq("ログアウトしました")
    end
  end
end
