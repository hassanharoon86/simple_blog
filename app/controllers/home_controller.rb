class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user)
  end
end
