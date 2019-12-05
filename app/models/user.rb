# frozen_string_literal: true

class User < ApplicationRecord
  include Regex

  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: Regex::EmailFormat }
end
