class UnreadRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "unread_rooms_channel"
  end
end
