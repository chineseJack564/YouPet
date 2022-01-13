# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.text :pictures
      t.integer :specie
      t.string :breed
      t.integer :post_type
      t.integer :price
      t.text :address
      t.boolean :open, default: true

      t.timestamps
    end
  end
end
