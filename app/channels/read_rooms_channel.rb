class ReadRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "read_rooms_channel"
  end
end
