# frozen_string_literal: true
class SaveMessageWorker
  include Sidekiq::Worker

  def perform(message_params)
    Message.create(message_params)
  end
end
