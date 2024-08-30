require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  let(:post_instance) { create(:post, user: user) }

  before do
    login_as(user, scope: :user)
  end

  context "POST /posts/:post_id/likes" do
    it "creates a like for the post" do
      post post_likes_path(post_instance), params: { like: { likeable_type: "Post", likeable_id: post_instance.id} }
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Item liked!')
    end
  end

  context "DELETE /posts/:post_id/likes/:id" do
    let!(:like) { create(:like, user: user, likeable: post_instance) }

    it "removes the like from the post" do
      delete post_like_path(post_instance, like)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Item unliked!')
    end
  end
end
