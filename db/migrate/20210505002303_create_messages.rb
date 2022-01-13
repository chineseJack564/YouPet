# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :sender, index: true
      t.references :recipient, index: true
      t.references :chat, index: true
      t.text :body
      t.boolean :unread?, null: false, default: true

      t.timestamps
    end
  end
end
