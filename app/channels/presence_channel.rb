class PresenceChannel < ApplicationCable::Channel
  def subscribed
    logger.info "subscribed to RoomChannel, roomID: #{params[:roomId]}"

    @room = Room.find(params[:roomId])
    stream_from "presence_channel_#{@room.id}"
    ParticipantService.new(user: current_user, room: @room).create
  end

  def unsubscribed
    logger.info "unsubscribed from PresenceChannel"

    @room = Room.find(params[:roomId])
    ParticipantService.new(user: current_user, room: @room).destroy
  end
end
