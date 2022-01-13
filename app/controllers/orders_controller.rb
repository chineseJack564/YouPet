# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    if current_user
      @post = Post.find(params[:post_id])
      @order = @post.orders.create order_params
      @order.status = 'pending'
      if @order.save
        create_notification
        redirect_to post_path(@post)
      end
    else
      redirect_to new_user_session_path and return
    end
  end

  def destroy
    if current_user
      @post = Post.find(params[:post_id])
      @order = @post.orders.find(params[:id])
      @order.destroy
      redirect_to post_path(@post)
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @order = @post.orders.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @order = @post.orders.find(params[:id])
    @order.update(order_params)
    redirect_to post_path(@post)
  end

  private

  def order_params
    params.require(:order).permit(:body, :post_id).merge(user_id: current_user.id)
  end

  def create_notification
    @sender = current_user
    @notification = Notification.create(to_id: @post.user.id, from_id: @sender.id, user?: true, notificator: @order)
    @post.user.increment!('unread_notifications')
  end
end
