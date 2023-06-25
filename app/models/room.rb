class Room < ApplicationRecord
  before_create :generate_token

  has_many :messages, dependent: :destroy
  has_many :members, dependent: :destroy

  def to_param
    token
  end

  private

  def generate_token
    self.token = SecureRandom.hex(3)
  end
end
