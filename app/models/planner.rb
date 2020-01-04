# frozen_string_literal: true

class Planner < User
  default_scope -> { where(user_type: :planner) }
  has_many: :available_frames
  has_many: :reservations
end
