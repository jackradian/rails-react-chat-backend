class UserRelationship < ApplicationRecord
  belongs_to :user_one, class_name: "User"
  belongs_to :user_two, class_name: "User"

  enum relationship_type: {
    request_pending_one_two: 0,
    request_pending_two_one: 1,
    friends: 2,
    block_one_two: 3,
    block_two_one: 4,
    block_both: 5
  }
end
