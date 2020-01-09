# frozen_string_literal: true

require "rails_helper"

RSpec.describe ClientsController, type: :request do
  describe "GET /clients/join" do
    it { is_expected.to eq(200) }
  end

  describe "POST /clients" do
    context "valid params" do
      let(:params) {
        {
          client: {
            name: "test2",
            email: "qwert@test.com",
            password: "qpwoei1029",
            password_confirmation: "qpwoei1029"
          }
        }
      }
      it do
        is_expected.to eq(302)
        expect(flash[:success]).to eq("ユーザー登録が完了しました.")
      end
    end

    context "invalid params" do
      let(:params) {
        {
          client: {
            name: "test2",
            email: "qwertterws",
            password: "qpwoei1029",
            password_confirmation: "qpwoei1029"
          }
        }
      }
      it do
        is_expected.to eq(422)
        expect(flash[:danger]).to eq("ユーザー登録に失敗しました.")
      end
    end
  end
end
