class MemberService
  def initialize(user:, room:)
    @user = user
    @room = room
  end

  def create
    create_member!
    broadcast_message
  end

  def destroy
    destroy_member!
    broadcast_message
  end

  private

  def create_member!
    Member.create!(room: @room, user: @user)
  end

  def destroy_member!
    Member.where(room: @room, user: @user).destroy_all
  end

  def broadcast_message
    ActionCable.server.broadcast "presence_channel_#{@room.id}", { message: render_message }
  end

  def render_message
    ApplicationController.renderer.render(partial: 'members/member', collection: @room.members, as: :member)
  end
end
