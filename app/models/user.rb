class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, ImageUploader

  validates :full_name, presence: true

  has_many :posts
  has_many :relationships, foreign_key: :follower_id
  has_many :follower_relationships, class_name: 'Relationship', foreign_key: :followed_id
  has_many :followers, through: :follower_relationships
  has_many :notifications

  def follow?(user)
    relationships.exists?(followed_id: user.id)
  end
end
