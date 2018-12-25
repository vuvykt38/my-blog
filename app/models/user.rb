class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, ImageUploader

  validates :full_name, presence: true

  has_many :posts

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: :followed_id
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :following_users, through: :following_relationships, source: :followed

  has_many :notifications, dependent: :destroy

  has_many :messages

  has_many :user_conversations
  has_many :conversations, through: :user_conversations

  def following?(user)
    following_relationships.exists?(followed_id: user.id)
  end
end
