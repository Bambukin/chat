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
    participant.connections += 1
    participant.save!
  end

  def destroy_participant!
    participant = Participant.where(room: @room, user: @user).first
    participant.connections -= 1
    participant.connections.zero? ? participant.destroy! : participant.save!
  end

  def broadcast_message
    ActionCable.server.broadcast "presence_channel_#{@room.id}", { message: render_message }
  end

  def render_message
    ApplicationController.renderer.render(partial: 'participants/participant', collection: @room.participants, as: :participant)
  end
end
