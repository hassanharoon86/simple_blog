class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user)
  end
end
