# frozen_string_literal: true

class User < ApplicationRecord
  enum type: {
    client: 0,
    planner: 1
  }

  has_secure_password
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: ValidFormat::EMAIL_FORMAT }
  validates :type, presence: true, inclusion: { in: types.keys }
end
