# frozen_string_literal: true

class Review < ApplicationRecord
  enum score: { "☆": 0, "☆☆": 1,
                "☆☆☆": 2, "☆☆☆☆": 3, "☆☆☆☆☆": 4 }
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :notifications, as: :notificator
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true
  validates :anon, presence: true
end
