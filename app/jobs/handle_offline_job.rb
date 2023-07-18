class HandleOfflineJob < ApplicationJob
  queue_as :critical

  def perform(user, room)

    return if ParticipantService.still_connected?(user) # might have other tabs open

    ParticipantService.new(user: user, room: room).destroy
  end
end
