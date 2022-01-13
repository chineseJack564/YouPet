# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :title, presence: true,
                    length: { minimum: 5 }
  validates :content, presence: true
  belongs_to :sender, class_name: 'User'
  belongs_to :post
  has_many :replies, dependent: :destroy
end
