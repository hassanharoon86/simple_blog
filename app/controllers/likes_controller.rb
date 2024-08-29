class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post.likes.create(user: current_user)
    redirect_to root_path, notice: 'Post liked!'
  end

  def destroy
    @post.likes.find_by(user: current_user).destroy
    redirect_to root_path, notice: 'Post unliked!'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
