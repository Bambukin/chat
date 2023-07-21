class HandleOfflineJob
  include Sidekiq::Job

  def perform(*args)
    user = User.find_by(id: args[0])
    room = Room.find_by(id: args[1])

    return if ParticipantService.still_connected?(user)

    ParticipantService.new(user:, room:).destroy
  end
end
