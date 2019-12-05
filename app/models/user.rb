class User < ActiveRecord::Base
  include Regex

  has_secure_password

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 320 }
end