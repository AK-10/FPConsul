# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    it { is_expected.to belongs_to(:user).with_foreign_key(:user_id) }
    it { is_expected.to belongs_to(:planner).with_foreign_key(:planner_id) }

    it { is_expected.to validate_presence_of(:scheduled_at) }
    it { is_expected.to validate_length_of(:description).is_at_most(200) }
  end
end
