# frozen_string_literal: true

class Planner < User
  has_secure_password
  has_many :available_frames, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }, format: { with: ValidFormat::EMAIL_FORMAT }
end
