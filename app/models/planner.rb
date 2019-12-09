class Planner < ApplicationRecord
  include Regex

  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: Regex::EMAIL_FORMAT }, allow_nil: true
end