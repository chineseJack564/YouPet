# frozen_string_literal: true

ActiveAdmin.register Notification do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :to_id, :from_id, :notificator_type, :notificator_id, :user?
  #
  # or
  #
  # permit_params do
  #   permitted = [:to_id, :from_id, :notificator_type, :notificator_id, :user?]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
