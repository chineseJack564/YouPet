# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :phone,
            format: { with: /\+569\d{8}\z/ },
            unless: ->(x) { x.phone.blank? }

  has_many :chats
  has_many :messages, through: :chat
  has_one_attached :avatar
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def destroy
    update(deactivated: true) unless deactivated
  end

  def active_for_authentication?
    super && !deactivated
  end
end
