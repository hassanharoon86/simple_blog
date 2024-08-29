require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post_instance) { FactoryBot.create(:post, user: user) }

  before do
    login_as(user, scope: :user) # Ensure user is signed in
  end

  context "GET /index" do
    it "renders the index page" do
      get posts_path
      expect(response).to render_template :index
    end
  end

  context "GET /new" do
    it "renders the new page" do
      get new_post_path
      expect(response).to render_template :new
    end
  end

  context "GET /edit" do
    it "renders the edit page" do
      get edit_post_path(post_instance)
      expect(response).to render_template :edit
    end
  end

  context "POST /create" do
    it "creates a post with valid attributes" do
      post posts_path, params: { post: FactoryBot.attributes_for(:post) }
      expect(response).to redirect_to posts_path
      expect(flash[:notice]).to eq 'Post was successfully created.'
    end

    it "does not create a post with invalid attributes" do
      post posts_path, params: { post: FactoryBot.attributes_for(:post, title: nil) }
      expect(response).to render_template :new
      expect(flash[:notice]).to be_nil
    end
  end

  context "PUT /update" do
    it "updates a post with valid attributes" do
      put post_path(post_instance), params: { post: FactoryBot.attributes_for(:post, title: "Updated Title") }
      expect(response).to redirect_to post_path(post_instance)
      expect(flash[:notice]).to eq 'Post was successfully updated.'
    end

    it "does not update a post with invalid attributes" do
      put post_path(post_instance), params: { post: FactoryBot.attributes_for(:post, title: nil) }
      expect(response).to render_template :edit
      expect(flash[:notice]).to be_nil
    end
  end

  context "DELETE /destroy" do
    it "destroys a post" do
      delete post_path(post_instance)
      expect(response).to redirect_to posts_path
      expect(flash[:notice]).to eq 'Post was successfully deleted.'
    end
  end
end
