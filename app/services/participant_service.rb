class ParticipantService
  def self.still_connected?(user)
    still_there = PresenceChannel.broadcast_to(user, action: 'presence-check')

    return true if still_there.to_i.positive?

    false
  end

  def initialize(user:, room:)
    @user = user
    @room = room
  end

  def create
    create_participant!
    broadcast_status('online')
  end

  def destroy
    destroy_participant!
    broadcast_status('offline')
  end

  private

  def create_participant!
    participant = Participant.find_or_create_by!(room: @room, user: @user)
    participant.save!
  end

  def destroy_participant!
    participant = Participant.where(room: @room, user: @user).first
    participant.destroy!
  end

  def broadcast_status(status)
    ActionCable.server.broadcast "status_channel_#{@room.id}", { user: @user.nickname, status: }
  end
end
