require 'rails_helper'

# scheduled_timeだけを切り出したモデルを作成
module TestModel
  ScheduledTimeValidatable = Struct.new(:scheduled_time) do
    include ActiveModel::Validations

    validates :scheduled_time, scheduled_time: true
  end
end

RSpec.describe ScheduledTimeValidator, type: :validator do
  
  around do |e|
    travel_to("2019-12-18 12:00:00") { e.run }
  end

  subject { validatable.valid? }
  let(:validatable) { TestModel::ScheduledTimeValidatable.new(scheduled_time) }

  describe 'valid pattern' do
    context 'on weekdays' do
      let(:scheduled_time) { '2019-12-18 12:30:00'.to_time }
      it { expect { subject }.not_to change { validatable.errors[:scheduled_time] } }
    end

    context 'on saturday' do
      let(:scheduled_time) { '2019-12-21 12:00:00'.to_time }
      it { expect { subject }.not_to change { validatable.errors[:scheduled_time] } }
    end

    context 'for minutes' do
      let(:scheduled_time) { '2019-12-18 12:30:00'.to_time }
      it { expect { subject }.not_to change { validatable.errors[:scheduled_time] } }
    end
  end

  describe 'invalid pattern' do
    context 'on weekdays' do
      let(:scheduled_time) { '2019-12-18 18:30:00'.to_time }
      it { expect { subject }.to change { validatable.errors[:scheduled_time] }.from([]).to(["can't be except 10:00 - 18:00"]) }
    end

    context 'on saturday' do
      let(:scheduled_time) { '2019-12-21 16:00:00'.to_time }
      it { expect { subject }.to change { validatable.errors[:scheduled_time] }.from([]).to(["can't be except 11:00 - 15:00 on saturday"]) }
    end

    context 'for minutes' do
      let(:scheduled_time) { '2019-12-18 12:35:00'.to_time }
      it { expect { subject }.to change { validatable.errors[:scheduled_time] }.from([]).to(["can't be except 0 or 30 minutes"]) }
    end

    context 'on sunday' do
      let(:scheduled_time) { '2019-12-22 16:00:00'.to_time }
      it { expect { subject }.to change { validatable.errors[:scheduled_time] }.from([]).to(["can't be sunday"]) }
    end

    context 'on past' do
      let(:scheduled_time) { '2019-12-17 16:00:00'.to_time }
      it { expect { subject }.to change { validatable.errors[:scheduled_time] }.from([]).to(["can't be past"]) }
    end
  end
end
