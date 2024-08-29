require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post_instance) { FactoryBot.create(:post, user: user) }
  
  before do
    login_as(user, scope: :user)
  end

  context "POST /create" do
    it "creates a like for a post" do
      post post_likes_path(post_instance)
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to eq 'Post liked!'
    end
  end

  context "DELETE /destroy" do
    it "destroys a like for a post" do
      FactoryBot.create(:like, post: post_instance, user: user)
      delete post_likes_path(post_instance)
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to eq 'Post unliked!'
    end
  end
end
