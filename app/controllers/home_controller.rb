class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user)
    @likes = current_user.likes.where(likeable_type: "Post").index_by(&:likeable_id)
  end
end
