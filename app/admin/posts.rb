# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :user_id, :title, :specie, :breed, :post_type, :price, :address, :description, :open
end
