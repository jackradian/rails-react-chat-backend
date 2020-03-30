# frozen_string_literal: true
class Participant < ApplicationRecord
  belongs_to :room
  belongs_to :user
end
