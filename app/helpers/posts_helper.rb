# frozen_string_literal: true

module PostsHelper
  def current_user_orders(inst_post)
    if current_user
      current_user.orders.select { |order| order.post == inst_post }
    else
      []
    end
  end

  def css_id_post(post)
    "#post_b#{post.id}"
  end

  def css_id_post2(post)
    "post_b#{post.id}"
  end
end
