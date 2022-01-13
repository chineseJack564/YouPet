# frozen_string_literal: true

module OrdersHelper
  def order_belongs_to_user?(order)
    order.user == current_user
  end
end
