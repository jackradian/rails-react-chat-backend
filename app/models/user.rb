class User < ApplicationRecord
  has_secure_password

  has_many :messages
  has_many :participants

  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :password, length: { in: 6..128 }
  validates :nickname, presence: true, uniqueness: { case_sensitive: true }

  def friends
    User.where("id IN (
      SELECT user_two_id
        FROM user_relationships
        WHERE user_one_id = ?
      UNION
      SELECT DISTINCT ff.user_two_id
        FROM user_relationships f
        JOIN user_relationships ff ON ff.user_one_id = f.user_two_id
        WHERE f.user_one_id = ?
    )", self.id, self.id)
  end
end
