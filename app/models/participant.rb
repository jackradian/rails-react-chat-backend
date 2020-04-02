# frozen_string_literal: true
class Participant < ApplicationRecord
  belongs_to :room
  belongs_to :user

  enum status: {
    invite_pending: 0,
    accepted: 1,
    block: 2
  }
end
