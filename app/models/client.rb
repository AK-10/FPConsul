class Client < User
  default_scope -> { where(user_type: :client) }
end