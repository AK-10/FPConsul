# frozen_string_literal: true

class Planner < User
  default_scope { where(user_type: :planner) }

  has_many :available_frames, dependent: :destroy
  has_many :reservations, foreign_key: "planner_id", dependent: :destroy
end
