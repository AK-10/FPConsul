# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AvailableFrameDecorator do
  let(:available_frame) { AvailableFrame.new.extend AvailableFrameDecorator }
  subject { available_frame }
  it { should be_a AvailableFrame }
end
