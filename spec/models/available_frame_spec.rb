require 'rails_helper'

RSpec.describe AvailableFrame, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:planner) }
    it { is_expected.to validate_presence_of(:scheduled_time) }

    context 'planner_id-scheduled_time uniquenss validation' do
      before { create(:available_frame, scheduled_time: "2019-12-12 13:30:00".to_time) }

      it { is_expected.to validate_uniqueness_of(:planner_id).scoped_to(:scheduled_time) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:planner) }
  end
end
