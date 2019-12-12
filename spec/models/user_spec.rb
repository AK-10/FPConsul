# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(100) }

    it { is_expected.to allow_value('test@test.com').for(:email) }
    it { is_expected.not_to allow_value('abcdefg').for(:email) }

    it { is_expected.to have_secure_password }

    context 'email uniqueness validation' do
      before { create(:user) }
      it { is_expected.to validate_uniqueness_of(:email) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:reservations) }
  end
end
