class Message < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def message_time
    created_at.strftime("%b %d")
  end
end
