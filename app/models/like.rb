class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  after_create :update_post_likes
  after_destroy :update_post_likes

  private

  def update_post_likes
    post.update_column(:likes_count, post.likes.count)
  end
end
