require 'rails_helper'

RSpec.describe PlannersController, type: :request do
  describe "GET /planners/join" do
    it { is_expected.to eq(200) }
  end

  describe "POST /planners" do
    context "valid params" do
      let(:params) {
        {
          planner: {
            name: "planner test2",
            email: "qwert@planner.com",
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
          planner: {
            name: "test2",
            email: "qwertterws",
            password: "qpwoei1029",
            password_confirmation: "qpwoei1029"
          }
        }
      }
      it { is_expected.to eq(422) }
    end
  end
end
