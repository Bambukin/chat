class StatusChannel < ApplicationCable::Channel

  after_unsubscribe :handle_offline

  def subscribed
    logger.info "subscribed to StatusChannel, roomID: #{params[:roomId]}"

    @room = Room.find(params[:roomId])
    stream_from "status_channel_#{@room.id}"
    ParticipantService.new(user: current_user, room: @room).create
  end

  def unsubscribed
    logger.info "unsubscribed from StatusChannel"

    @room = Room.find(params[:roomId])
  end

  private

  def handle_offline
    HandleOfflineJob.perform_in(5.seconds, current_user.id, @room.id)
  end
end
