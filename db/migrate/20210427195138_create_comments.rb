# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :post, index: true
      t.text :content
      t.belongs_to :sender, index: true
      t.datetime :create_date
      t.string :title
      t.timestamps
    end
  end
end
