class Conversation < ApplicationRecord
  has_many :private_messages
  belongs_to :first_participate, class_name: 'User'
  belongs_to :second_participate, class_name: 'User'
  belongs_to :last_message, class_name: 'PrivateMessage', foreign_key: 'last_message_id', optional: true

  scope :conversations_of, lambda { |user|
    where('second_participate_id = :user_id OR first_participate_id = :user_id',
          user_id: user.id)
  }

  def self.conversation_for(user_id, other_id)
    Conversation.find_or_create_by(first_participate_id: [user_id, other_id].min,
                                   second_participate_id: [user_id, other_id].max)
  end

  def other_user(current_user)
    current_user == first_participate ? second_participate : first_participate
  end

  def message_time
    created_at.strftime("%b %d")
  end
end
