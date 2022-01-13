# frozen_string_literal: true

class Reply < ApplicationRecord
  belongs_to :comment
  belongs_to :sender, class_name: 'User'
  validates :content, presence: true
end
