class Post < ApplicationRecord
  STATUSES = %w[public draft]
  has_many :comments, as: :commentable, dependent: :destroy

  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :category

  validates :title, presence: true,
                    length: { minimum: 5 }

  validates :body, presence: true,
                    length: { minimum: 100 }

  validates_inclusion_of :status, in: STATUSES
  mount_uploader :image, ImageUploader
  validates_presence_of :image

  scope :posts_for, ->(user) { where('status = ? OR user_id = ?', 'public', user&.id) }
  scope :search_by, ->(keyword) { where('body LIKE ? OR title LIKE ?', "%#{keyword}%", "%#{keyword}%") }

  after_create :notify_followers

  private

  def notify_followers
    author.followers.each do |user|
      user.notifications.create(
        title: "has posted a new post: #{title}",
        full_name: author.full_name,
        image: author.avatar.url,
        link: Rails.application.routes.url_helpers.post_path(id)
      )
    end
  end
end
