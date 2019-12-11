# frozen_string_literal: true

class Planner < ApplicationRecord

  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: ValidFormat::EMAIL_FORMAT }, allow_nil: true
end
