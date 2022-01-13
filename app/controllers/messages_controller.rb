# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!, :set_message, only: %i[update delete]
  before_action :check_logged_status, only: %i[show]

  def index
    @messages = Message.all
  end

  def show
    begin
      @chat = Chat.find(params[:chat_id])
    rescue
      redirect_to error_index_path and return
    end
    @sender = current_user
    @recipient = User.find params[:recipient_id]
    @messages = @chat.messages
    return unless @sender.id == @recipient.id

    redirect_to users_index_path
    flash.notice = "Can't send yourself a message"
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.create! message_params.merge(chat: @chat)
    return unless @message.save



    respond_to do |format|
      format.js { render 'messages/create.js.erb' }
    end
  end

  def update
    @message.update params.permit(:body)
    redirect_to messages_show_path message_params.merge(chat_id: @chat.id)
  end

  def delete
    @message.delete
    redirect_to messages_show_path message_params.merge(chat_id: @chat.id)
  end

  private

  def set_message
    @message = Message.find params[:id]
  end

  def message_params
    params.permit(:body, :sender_id, :recipient_id, :chat_id)
  end

  def create_notification
    @sender = current_user
    @recipient = User.find params[:recipient_id]
    @notification = Notification.create(to_id: @recipient.id, from_id: @sender.id, user?: true, notificator: @message)
  end

  def check_logged_status
    return if current_user

    flash.notice = 'You must log in first'
    redirect_to users_index_path and return
  end
end
