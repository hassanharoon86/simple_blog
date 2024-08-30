class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }

  after_create :update_likes_count
  after_destroy :update_likes_count

  private

  def update_likes_count
    likeable.update_column(:likes_count, likeable.likes.count)
  end
end
