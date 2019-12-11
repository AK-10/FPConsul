# frozen_string_literal: true

class Planner < ApplicationRecord

  has_secure_password
  has_many :reservations

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: ValidFormat::EMAIL_FORMAT }
end
