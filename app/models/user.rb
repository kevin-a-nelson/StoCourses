class User < ApplicationRecord
  has_secure_password
  validates :email, presense: true, uniqueness: true
end
