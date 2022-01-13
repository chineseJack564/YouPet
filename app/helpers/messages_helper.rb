# frozen_string_literal: true

module MessagesHelper
  def logged_in_message_link(user)
    current = current_user || -1
    link_to 'Send message', chats_create_path(current, user)
  end
end
