# frozen_string_literal: true

class RepliesController < ApplicationController

  def create
    if current_user
      @comment = Comment.find(params[:comment_id])
      @post = @comment.post
      @reply_params = params.require(:reply).permit(:content).merge(sender_id: current_user.id)
      @reply = @comment.replies.create(@reply_params)
      if @reply.save
        create_notification
        redirect_to post_path(@post)
      end
    else
      flash.notice = 'You must log in first'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.find(params[:id])
    @reply_params = params.require(:reply).permit(:content).merge(sender_id: current_user.id)
    @post = @comment.post
    if @reply.update(@reply_params)
      redirect_to post_path(@post), notice: 'Reply has been updated'
    else
      redirect_to post_path(@post), notice: 'Reply update failed, try again'
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.find(params[:id])
    redirect_to post_path(@comment.post) and return unless @reply.sender == current_user

    @reply.destroy
    @post = @comment.post
    redirect_to post_path(@post), notice: 'Reply has been deleted'
  end

  private

  def create_notification
    @sender = current_user
    @notification = Notification.create!(to_id: @comment.sender.id, from_id: @sender.id, user?: true,
                                         notificator: @reply)
    @comment.sender.increment!('unread_notifications')
  end
end
