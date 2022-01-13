# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :verify_actions

  def index
    @chats = Chat.all
  end

  def show
    @chat = Chat.between(chat_params[:sender_id], chat_params[:recipient_id]).first
    begin
      if current_user.id == @chat.recipient_id
        current_user.decrement!('unread_messages', @chat.recipient_unreads)
        @chat.update_columns(recipient_unreads: 0)
      else
        current_user.decrement!('unread_messages', @chat.sender_unreads)
        @chat.update_columns(sender_unreads: 0)
      end

      respond_to do |format|
        format.js { render 'chats/show.js.erb' }
      end
    rescue
      redirect_to error_index_path and return
    end
  end

  def create
    @chat = Chat.between(chat_params[:sender_id], chat_params[:recipient_id]).first
    @chat ||= Chat.create! chat_params

    redirect_to chats_show_path chat_params
  end

  def update_c
    @chat = Chat.between(chat_params[:sender_id], chat_params[:recipient_id]).first
    if current_user.unread_messages > 0
      current_user.decrement!('unread_messages')
    end
    if @chat.recipient_id == helpers.other(@chat).id
      @chat.update_columns(sender_unreads: 0)
    else
      @chat.update_columns(recipient_unreads: 0)
    end  
  end

  private

  def chat_params
    params.permit(:sender_id, :recipient_id)
  end

  def verify_actions
    unless current_user
      redirect_to new_user_session_path and return
    end
  end

end
