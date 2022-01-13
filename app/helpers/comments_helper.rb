# frozen_string_literal: true

module CommentsHelper
  def css_id_com(com)
    "#com_b#{com.id}"
  end

  def css_id_com2(com)
    "com_b#{com.id}"
  end
end
