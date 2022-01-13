# frozen_string_literal: true

module WelcomeHelper
  def include_image(user)
    if user.avatar.attached?
      image_tag user.avatar, class: 'avatar-own'
    else
      image_tag '/default-user.png', class: 'avatar-own'
    end
  end
end
