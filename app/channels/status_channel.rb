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
    HandleOfflineJob
      .set(wait_until: Time.zone.now + 5)
      .perform_later(current_user, @room)
  end
end
