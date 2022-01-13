# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :sender, index: true
      t.references :recipient, index: true
      t.boolean :open
      t.integer :recipient_unreads, null: false, default: 0
      t.integer :sender_unreads, null: false, default: 0

      t.timestamps
    end
  end
end
