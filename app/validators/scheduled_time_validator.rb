class ScheduledTimeValidator < ActiveModel::EachValidator
  attr_reader :record, :attribute, :value
  
  def validate_each(record, attribute, value)
    record = record
    @attribute = attribute
    @value = value

    validate_time_range
    validate_time_range_on_saturday
    validate_minutes
    validate_sunday
    validate_past
  end

  private

    def validate_time_range
      start_time = value.change(hour: 10, min: 0)
      end_time = value.change(hour: 17, min: 30)
      return if value.between?(start_time, end_time)

      record.errors.add(attribute, "can't be except 10:00 - 18:00")
    end

    def validate_time_range_on_saturday
      start_time = value.change(hour: 11, min: 0)
      end_time = value.change(hour: 14, min: 30)

      return unless value.saturday?
      return if value.between?(start_time, end_time)

      record.errors.add(attribute, "can't be except 11:00 - 15:00 on saturday")
    end

    def validate_minutes
      minutes = value.min
      record.errors.add(attribute, "can't be except 0, 30") if minutes % 30 != 0
    end

    def validate_sunday
      record.errors.add(attribute, "can't be sunday") if value.sunday?
    end

    def validate_past
      record.errors.add(attribute, "can't be past") if value.past?
    end 
end
