# frozen_string_literal: true

class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(messageHTML, message)
    ActionCable.server.broadcast "chat#{message.chat.id}", {
      message: messageHTML,
      chat: message.chat,
      sender: message.sender,
      recipient: message.recipient
    }
  end

  private

  def render_message(message)
    MessagesController.render(
      partial: 'message',
      locals: {
        message: message
      }
    )
  end
end
