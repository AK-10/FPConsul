# frozen_string_literal: true

class User < ApplicationRecord
  include Regex

  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }, allow_nil: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: Regex::EmailFormat }, allow_nil: true
end
