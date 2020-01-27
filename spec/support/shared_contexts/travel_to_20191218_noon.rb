# frozen_string_literal: true

RSpec.shared_context "travel_to_20191218_noon" do
  around do |e|
    travel_to("2019-12-18 12:00:00") { e.run }
  end
end
