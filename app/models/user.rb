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

  def home_path
    "/#{user_type.pluralize}/home"
  end
end
