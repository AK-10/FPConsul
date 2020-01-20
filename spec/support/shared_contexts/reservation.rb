RSpec.shared_context "reservation_have_already_created" do
  let(:available_frame) { create(:available_frame, scheduled_time: "2019-12-19 12:00:00") }

  before { create(:reservation, available_frame: available_frame) }
end
