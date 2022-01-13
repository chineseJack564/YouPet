# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :to, index: true
      t.references :from, index: true
      t.references :notificator, polymorphic: true, index: true
      t.boolean :user?
      t.boolean :unread?, null: false, default: true

      t.timestamps
    end
  end
end
