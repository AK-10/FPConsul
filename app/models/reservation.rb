class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :planner

  validates :description, length: { maximum: 200 }

end