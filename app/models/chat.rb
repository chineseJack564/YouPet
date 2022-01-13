# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :messages, dependent: :destroy

  scope :between, lambda { |sender_id, recipient_id|
                    where(
                      '(sender_id = :ids AND recipient_id = :idr) OR (sender_id = :idr AND recipient_id = :ids)',
                      { ids: sender_id, idr: recipient_id }
                    )
                  }
  scope :user, lambda { |current_user|
    where('sender_id=:id OR recipient_id=:id', { id: current_user })
  }
end
