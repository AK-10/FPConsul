RSpec.shared_context "user_have_already_created" do
  before { create(:user, email: "already@created.com") }
end