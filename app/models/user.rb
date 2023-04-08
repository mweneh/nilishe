class User < ApplicationRecord
    has_many :recipes
    enum :u_type, {user: 0, admin: 1}
    has_secure_password
  end