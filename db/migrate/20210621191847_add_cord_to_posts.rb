# frozen_string_literal: true

class AddCordToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :coord_x, :decimal
    add_column :posts, :coord_y, :decimal
  end
end
