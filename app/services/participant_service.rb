class ParticipantService
  def initialize(user:, room:)
    @user = user
    @room = room
  end

  def create
    create_participant!
    broadcast_message
  end

  def destroy
    destroy_participant!
    broadcast_message
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

  def broadcast_message
    ActionCable.server.broadcast "status_channel_#{@room.id}", { message: render_message }
  end

  def render_message
    user_names = @room.participants.map { |participant| participant.user.nickname }
    { names: user_names }.to_json
  end
end
