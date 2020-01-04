# frozen_string_literal: true

class User < ApplicationRecord
  enum user_type: {
    client: 0,
    planner: 1
  }

  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: ValidFormat::EMAIL_FORMAT }
  validates :user_type, presence: true, inclusion: { in: user_types.keys }

  def convert_with_user_type
    attrs = attributes
    case attrs.delete("user_type")
    when "client"
      return Client.new(attrs)
    when "planner"
      return Planner.new(attrs)
    end
  end

  # def convert_with_user_type
  #   attrs = attributes
  #   klass = attrs.delete("user_type")
  #   eval("#{klass.capitalize}.new(attrs)")
  # end
end
