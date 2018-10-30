class Post < ApplicationRecord
  STATUSES = %w[public draft]
  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :category
  validates :title, presence: true,
                    length: { minimum: 5 }
  validates_inclusion_of :status, in: STATUSES
  mount_uploader :image, ImageUploader

  scope :posts_for, ->(user) { where('status = ? OR user_id = ?', 'public', user&.id) }
end
