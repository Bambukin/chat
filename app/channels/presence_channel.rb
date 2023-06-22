class PresenceChannel < ApplicationCable::Channel
  def subscribed
    logger.info "subscribed to RoomChannel, roomID: #{params[:roomId]}"

    @room = Room.find(params[:roomId])
    stream_from "presence_channel_#{@room.id}"
    ActionCable.server.broadcast "presence_channel_#{@room.id}", { message: current_user.nickname }
  end

  def unsubscribed
    logger.info "unsubscribed from PresenceChannel"
    ActionCable.server.broadcast "presence_channel_#{@room.id}", { message: current_user.nickname }
  end
end
