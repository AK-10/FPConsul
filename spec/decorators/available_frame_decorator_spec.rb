# frozen_string_literal: true

require "rails_helper"

RSpec.describe AvailableFrameDecorator do
  include_context "travel_to_20191218_noon"

  describe "formatted_scheduled_time" do
    let(:decorated_available_frame) { ActiveDecorator::Decorator.instance.decorate available_frame }
    subject { decorated_available_frame.formatted_scheduled_time }

    context "future, not appearing (終了)" do
      let(:available_frame) { build(:available_frame, scheduled_time: "2019-12-18 12:30:00") }
      it { is_expected.to eq("2019年 12月 18日 (Wed) 12:30 ~ 13:00") }
    end

    context "past, appearing (終了)" do
      let(:available_frame) { build(:available_frame, scheduled_time: "2019-12-17 12:30:00") }
      it { is_expected.to eq("2019年 12月 17日 (Tue) 12:30 ~ 13:00(終了)") }
    end
  end
end
