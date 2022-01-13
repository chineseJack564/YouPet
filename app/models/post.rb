# frozen_string_literal: true

class Post < ApplicationRecord
  enum post_type: { Adoption: 0, Sale: 1 }
  enum specie: { Dog: 0, Cat: 1, Hamster: 2, Bird: 3, Fish: 4, Rabbit: 5, Other: 6 }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notificator
  has_one_attached :avatar_main
  has_one_attached :avatar2
  has_one_attached :avatar3
  validates :title, presence: true, length: { minimum: 5 }
  validates :address, presence: true
  validates :avatar_main, presence: true, blob: { content_type: :image }
  validates :avatar2, blob: { content_type: :image }
  validates :avatar3, blob: { content_type: :image }
  validates :description, presence: true
  validates :specie, presence: true
  validates :post_type, presence: true
  validates :coord_x, presence: true
  validates :coord_y, presence: true
end
