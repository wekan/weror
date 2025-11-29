class TypingNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "typing_notifications_channel"
  end
end
