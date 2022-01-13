# frozen_string_literal: true

ActiveAdmin.register Comment do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :post_id, :content, :sender_id, :create_date, :title
  #
  # or
  #
  # permit_params do
  #   permitted = [:post_id, :content, :sender_id, :create_date, :title]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
