require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  
  it { should belong_to(:user) }
  it { should belong_to(:post) }
  
  it "validates uniqueness of user_id scoped to post_id" do
    create(:like, user: user, post: post)
    should validate_uniqueness_of(:user_id).scoped_to(:post_id)
  end

  context 'callbacks' do
    it 'updates the post likes_count after create' do
      new_user = create(:user)
      expect { create(:like, user: new_user, post: post) }.to change { post.reload.likes_count }.by(1)
    end

    it 'updates the post likes_count after destroy' do
      like = create(:like, user: user, post: post)
      expect { like.destroy }.to change { post.reload.likes_count }.by(-1)
    end
  end
end
