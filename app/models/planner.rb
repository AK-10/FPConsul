# frozen_string_literal: true

class Planner < User
  default_scope -> { where(user_type: :planner) }
end
