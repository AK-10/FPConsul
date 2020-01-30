# frozen_string_literal: true

RSpec.shared_context "login_by_client" do
  let(:client) { create(:client) }
  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: client.id })
  end
end

RSpec.shared_context "login_by_planner" do
  let(:planner) { create(:planner) }
  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({ user_id: planner.id })
  end
end
