# frozen_string_literal: true

module NotificationsHelper
  def try_deleted_content(notif)
    case notif.notificator_type
    when 'Review', 'Comment', 'Reply'
      notif.notificator.content
    when 'Order'
      notif.notificator.status
    else
      notif.notificator.body
    end
  rescue StandardError => _e
    '(deleted)'
  end
end
