# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      # pending | accepted | rejected | finished
      t.string :status
      t.text :body
      t.integer :buyer_reviewed, default: 0
      t.integer :seller_reviewed, default: 0
      t.timestamps
    end
  end
end
