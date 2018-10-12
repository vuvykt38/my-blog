class Post < ApplicationRecord
  has_many :comments
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :category
  validates :title, presence: true,
                    length: { minimum: 5 }
end
