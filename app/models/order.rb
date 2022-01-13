# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :notifications, as: :notificator
end
