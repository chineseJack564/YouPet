# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy accept_order reject_order]

  def index
    @p = Post.ransack(params[:q])
    @posts = @p.result
  end

  def show;
  end

  def new
    if current_user
      @post = Post.new
    else
      redirect_to new_user_session_path and return
    end
  end

  def create
    @post = Post.new(post_params)
    @post.open = true
    if @post.save
      flash.notice = 'Post saved'
      redirect_to posts_path
    else
      flash.notice = 'Error creating post'
      render 'new'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash.notice = 'Post updated'
      redirect_to @post
    else
      flash.notice = 'Error updating post'
      render 'edit'
    end
  end

  def accept_order
    contador = 0
    @post.orders.each do |o|
      contador += 1 if o.status == 'accepted'
    end
    if contador == 1
      @post.orders.each do |o|
        o.status = if o.id == params[:format].to_i
                     'finished'
                   else
                     'rejected'
                   end
        o.save
        create_notification(o) if o.status == 'finished'
      end
      @post.open = false
      @post.save
    elsif current_user.id == @post.user.id
      @post.orders.each do |o|
        o.status = if o.id == params[:format].to_i
                     'accepted'
                   else
                     'rejected'
                   end
        o.save
        create_notification(o)
      end
      @post.open = false
      @post.save
    else
      flash.notice = 'you dont have that perm'
    end
    redirect_to @post
  end

  def reject_order
    if current_user.id == @post.user.id
      order = @post.orders.find(params[:format].to_i)
      order.status = 'rejected'
      order.save
      create_notification(order)
    else
      flash.notice = 'you dont have that perm'
    end
    redirect_to @post
  end

  private

  def set_post
    if (@post = Post.find_by_id(params[:id])).present?
      @post = Post.find(params[:id])
    else
      redirect_to error_index_path
    end
    
  end

  def post_params
    params.require(:post).permit(:title, :breed, :specie, :post_type, :price, :address,
                                 :description, :avatar_main, :avatar2, :avatar3, :coord_x, :coord_y).merge(user_id: current_user.id)
  end

  def create_notification(order)
    @sender = current_user
    @notification = Notification.create!(to_id: order.user.id, from_id: @sender.id, user?: false, notificator: order)
    order.user.increment!('unread_notifications')
  end
end
