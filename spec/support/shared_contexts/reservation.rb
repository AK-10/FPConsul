
RSpec.shared_context "reservation_have_already_created" do

  before do
    around do |e|
      travel_to("2019-12-18 12:00:00") { e.run }
    end

    create(:avilable_frame, scheduled_time: "2019-12-19 12:00:00")
    create(:reservation, available_frame: available_frame)
  end
end