require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do

  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:planner) }
  end
end