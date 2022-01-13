# frozen_string_literal: true

module ChatsHelper
  def other(chat)
    chat.sender == current_user ? chat.recipient : chat.sender
  end
end
