# frozen_string_literal: true

class AddColumstoPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :description, :text
  end
end
