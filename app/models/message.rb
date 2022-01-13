# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :notifications, as: :notificator

  validates :body, presence: true
end
