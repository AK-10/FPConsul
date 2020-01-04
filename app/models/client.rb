class Client < User
  default_scope -> { where(user_type: :client) }
  has_many: :reservations
end