class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  default_scope { order(created_at: :desc) }

  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 160 }
end
