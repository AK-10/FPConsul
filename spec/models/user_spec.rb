# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(100) }

    it { is_expected.to allow_value("test@test.com").for(:email) }
    it { is_expected.not_to allow_value("abcdefg").for(:email) }

    it { is_expected.to have_secure_password }

    # unnecessary validate_inclusion_of
    # https://gitmemory.com/issue/thoughtbot/shoulda-matchers/1201/483780992
    it do
      is_expected.to define_enum_for(:user_type).
        with_values(
          client: 0,
          planner: 1
        )
    end
    it { is_expected.to validate_precence_of(:user_type) }

    context "email uniqueness validation" do
      include_context "user_have_already_created"
      it { is_expected.to validate_uniqueness_of(:email) }
    end

  end

  # describe "associations" do
  #   it { is_expected.to have_many(:reservations).dependent(:destroy) }
  # end
end
