class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :password, length: { in: 6..128 }
end
