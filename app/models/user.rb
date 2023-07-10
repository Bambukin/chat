class User < ApplicationRecord
  before_create :generate_nickname

  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy

  def still_connected?
    still_there = PresenceChannel.broadcast_to(self, action: 'presence-check')

    return true if still_there.is_a?(Integer) && still_there.positive?

    false
  end

  private

  def generate_nickname
    self.nickname = Faker::Name.first_name.downcase
  end
end
