# frozen_string_literal: true

ActiveAdmin.register Message do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :sender_id, :recipient_id, :body
  #
  # or
  #
  # permit_params do
  #   permitted = [:sender_id, :recipient_id, :body]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
