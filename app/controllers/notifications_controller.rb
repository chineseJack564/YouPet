# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :verify_actions

  def new
    @notification = Notification.new(notification_params)
  end

  def show
    if (@notification = Notification.find_by_id params[:id]).present?
      @notification = Notification.find params[:id]
      redirect_notifications @notification
    else
      redirect_to error_index_path
    end
  end

  def index
    @notifications = Notification.all
  end

  def delete
    @notification = Notification.find params[:id]
    if current_user.id == @notification.to_id
      @notification.destroy
    else
      redirect_back(fallback_location: root_path) and return
    end
    respond_to do |format|
      format.html { flash.notice = 'Deleted notification' }
      format.js { render 'notifications/delete.js.erb' }
    end
  end

  def update_n
    @notif = Notification.find(params[:id])
    @notif.update_columns(unread?: false)
    if current_user.unread_notifications > 0
      current_user.decrement!('unread_notifications')
    end

    respond_to do |format|
      format.js { render 'notifications/update.js.erb' }
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:to_id, :from_id, :user?, :notificator)
  end

  def redirect_notifications(notification)
    case notification.notificator_type
    when 'Review'
      if current_user.id == notification.to_id
      redirect_to users_show_path(current_user) and return
      end
    when 'Order'
      redirect_to posts_path and return unless notification.notificator

      try_redirection 'order', notification.notificator.post, posts_path
    when 'Comment'
      redirect_to posts_path and return unless notification.notificator

      try_redirection 'comment', notification.notificator.post, posts_path
    when 'Reply'
      redirect_to posts_path and return unless notification.notificator

      try_redirection 'comment', notification.notificator.comment.post, posts_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def try_redirection(name, attempted, fallback)
    redirect_to attempted
  rescue StandardError => _e
    flash.notice = "Notice: this #{name} was deleted"
    redirect_to fallback
  end

  def verify_actions
    begin
      if current_user.id != Notification.find(params[:id]).to_id
        redirect_to error_index_path and return
      end
    rescue
      redirect_to error_index_path and return
    end
  end

end
