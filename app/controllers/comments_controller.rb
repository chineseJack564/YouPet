# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    if current_user
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(comment_params)
      if @comment.save
        create_notification
        redirect_to post_path(@post)
      else
        flash.notice = 'error in comment creation'
        redirect_to post_path(@post)
      end
    
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment_params = params.require(:comment).permit(:title, :content)
    if @comment.update(@comment_params)
      redirect_to post_path(@post), notice: 'Comment has been updated'
    else
      redirect_to post_path(@post), notice: 'Comment update failed, try again'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment has been deleted'
  end

  private

  def create_notification
    @sender = current_user
    @notification = Notification.create(to_id: @post.user.id, from_id: @sender.id, user?: true, notificator: @comment)
    @post.user.increment!('unread_notifications')
  end

  def comment_params
    params.require(:comment).permit(:title, :content).merge(sender_id: current_user.id)
  end
end
