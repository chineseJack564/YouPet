# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat#{params[:chat]}"
  end

  def speak(data)
    puts("\n\nASSSSSSSSSSS, #{data}\n\n")
  end
end
