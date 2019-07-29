class User < ApplicationRecord
  has_secure_password
  validates :username, presense: true, uniqueness: true
end
