# frozen_string_literal: true

class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    if current_user
      @user = User.find current_user.id
      @reviews = Review.all
    else
      flash.notice = 'You must log in first'
      redirect_back(fallback_location: root_path)
    end
  end

  def new
    @sender = current_user
    @recipient = User.find params[:recipient_id]
    case @sender
    when nil
      flash.notice = 'You must log in first'
      redirect_to posts_path and return
    when @recipient
      flash.notice = 'You cant review yourself'
      redirect_to posts_path and return
    end
  end

  def create
    @review = Review.create review_params

    if @review.save
      create_notification
      redirect_to users_show_path(@review.recipient), notice: 'Review has been created'
    else
      redirect_to users_show_path(@review.recipient), notice: 'Review creation failed, try again'
    end
  end

  def delete
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to users_show_path(@review.recipient), notice: 'Review has been deleted'
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review_params1 = params.require(:review).permit(:title, :content, :anon, :score)
    if @review.update(@review_params1)
      redirect_to users_show_path(@review.sender_id), notice: 'Review has been updated'
    else
      redirect_to users_show_path(@review.sender_id), notice: 'Review update failed, try again'
    end
  end

  private

  def review_params
    params.permit(:anon, :title, :content, :score, :recipient_id).merge(sender_id: current_user.id)
  end

  def create_notification
    @sender = current_user
    @recipient = User.find params[:recipient_id]
    @notification = Notification.create(to_id: @recipient.id, from_id: @sender.id, user?: true, notificator: @review)
    @recipient.increment!('unread_notifications')
  end
end
