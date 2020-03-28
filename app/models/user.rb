class User < ApplicationRecord
  has_secure_password

  has_many :messages
  has_many :participants

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :password, length: { in: 6..128 }
  validates :nickname, presence: true, uniqueness: { case_sensitive: true }
end
