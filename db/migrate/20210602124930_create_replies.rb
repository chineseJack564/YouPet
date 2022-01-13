# frozen_string_literal: true

class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.belongs_to :comment, index: true
      t.belongs_to :sender, index: true
      t.text :content

      t.timestamps
    end
  end
end
