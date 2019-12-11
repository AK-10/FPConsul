# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    around do |e|
     travel_to('2019-12-11 17:00:00'.to_time) { e.run } 
    end
    subject { build(:reservation, scheduled_at: '2019-12-12 17:30:00'.to_time) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:planner) }

    it { is_expected.to validate_presence_of(:scheduled_at) }
    it { is_expected.to validate_length_of(:description).is_at_most(200) }
  end
end