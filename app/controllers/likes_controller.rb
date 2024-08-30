class LikesController < ApplicationController
  before_action :set_likeable

  def create
    @likeable.likes.create(user: current_user)
    redirect_to root_path, notice: 'Item liked!'
  end

  def destroy
    @likeable.likes.find_by(user: current_user).destroy
    redirect_to root_path, notice: 'Item unliked!'
  end
end
