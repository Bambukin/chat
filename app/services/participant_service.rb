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
    Participant.create(room: @room, user: @user)
  end

  def destroy_participant!
    Participant.where(room: @room, user: @user).destroy_all
  end

  def broadcast_message
    ActionCable.server.broadcast "presence_channel_#{@room.id}", { message: render_message }
  end

  def render_message
    ApplicationController.renderer.render(partial: 'participants/participant', collection: @room.participants, as: :participant)
  end
end
