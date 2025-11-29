class HeartbeatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "heartbeat_channel"
  end
end
