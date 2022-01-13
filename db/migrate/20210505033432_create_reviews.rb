# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :sender, index: true
      t.references :recipient, index: true
      t.integer :anon
      t.string :title
      t.text :content
      t.integer :score
      t.datetime :create_date

      t.timestamps
    end
  end
end
