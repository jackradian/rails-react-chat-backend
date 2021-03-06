# frozen_string_literal: true
class Message < ApplicationRecord
  belongs_to :room
  belongs_to :sender, class_name: "User"

  def sender_nickname
    sender&.nickname
  end
end
