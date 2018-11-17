class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  after_create :notify_author

  private

  def notify_author
    return unless commentable.is_a?(Post)
    author = commentable.author
      author.notifications.create(
        title: "has commented on your post: #{commentable.title} ",
        full_name: user.full_name,
        image: user.avatar.url,
        link: Rails.application.routes.url_helpers.post_path(id)
      )
  end
end
