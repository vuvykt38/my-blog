class PrivateMessage < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :conversation

  scope :unread, -> { where.not(read: true) }

  def message_time
    created_at.strftime("%b %d")
  end
end
