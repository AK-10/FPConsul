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

  subject { TestModel::ScheduledTimeValidatable.new }

  context 'time range on weekdays' do
    it 'is valid time' do
      subject.scheduled_time = '2019-12-18 12:30:00'.to_time
      subject.valid?
      expect(subject.errors[:scheduled_time]).not_to match_array "can't be except 10:00 - 18:00"
    end

    it 'is invalid time' do
      subject.scheduled_time = '2019-12-18 18:30:00'.to_time
      subject.valid?
      expect(subject.errors[:scheduled_time]).to match_array "can't be except 10:00 - 18:00"
    end
  end
  
  context 'time range on saturday' do
    it 'is valid time' do
      subject.scheduled_time = '2019-12-21 12:00:00'.to_time
      subject.valid?
      expect(subject.errors[:scheduled_time]).not_to match_array "can't be except 11:00 - 15:00 on saturday"
    end

    it 'invalid time' do
      subject.scheduled_time = '2019-12-21 16:00:00'.to_time
      subject.valid?
      expect(subject.errors[:scheduled_time]).to match_array "can't be except 11:00 - 15:00 on saturday"
    end
  end

  context 'minutes' do
    it 'valid minutes' do
      subject.scheduled_time = '2019-12-18 12:30:00'.to_time
      subject.valid?
      expect(subject.errors[:scheduled_time]).not_to match_array "can't be except 0 or 30 minutes"
    end

    it 'invalid minutes' do
      subject.scheduled_time = '2019-12-18 12:35:00'.to_time
      subject.valid?
      expect(subject.errors[:scheduled_time]).to match_array "can't be except 0 or 30 minutes"
    end
  end

  context 'on sunday' do
    it 'is invalid date' do
      subject.scheduled_time = '2019-12-22 16:00:00'.to_time
      subject.valid?
      expect(subject.errors[:scheduled_time]).to match_array "can't be sunday"
    end
  end

  context 'on past' do
    it 'is invalid date' do
      subject.scheduled_time = '2019-12-17 16:00:00'.to_time
      subject.valid?
      expect(subject.errors[:scheduled_time]).to match_array "can't be past"
    end
  end
end
