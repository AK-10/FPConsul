require 'rails_helper'

RSpec.describe Client, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:reservations).dependent(:destroy) }
  end
end