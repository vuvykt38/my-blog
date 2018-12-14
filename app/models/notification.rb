class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where.not(read: true) }
end
