# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    unless current_user
      redirect_to new_user_session_path and return
    end
    if (@user = User.find_by_id(params[:id])).present?
      @user = User.find(params[:id])
      @allchats = Chat.where('sender_id=:id OR recipient_id=:id', { id: @user.id })
      @recieved_reviews = Review.where('recipient_id=:id', { id: @user.id })
      @posted_reviews = Review.where('sender_id=:id', { id: @user.id })
    else
      redirect_to error_index_path
    end
  end

  def end
    @post = Post.find(params[:post_id])
    redirect_to @post
  end

  def darkmode
    $darkmode = current_user.darkmode? ? false : true
    current_user.update_columns(darkmode?: $darkmode)
  end


  private

  def user_params
    params.require(:user).permit(:id)
  end
end
