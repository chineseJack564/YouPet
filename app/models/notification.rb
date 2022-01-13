# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :to, class_name: 'User'
  belongs_to :from, class_name: 'User'
  belongs_to :notificator, polymorphic: true
  validates :to, presence: true
  validates :from, presence: true
end
