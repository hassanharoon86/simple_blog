require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  
  it { should belong_to(:user) }
  it { should belong_to(:likeable) }
  
  it "validates uniqueness of user_id scoped to likeable_id and likeable_type" do
    create(:like, user: user, likeable: post)
    should validate_uniqueness_of(:user_id).scoped_to(:likeable_id, :likeable_type)
  end

  context 'callbacks' do
    it 'updates the likeable likes_count after create' do
      new_user = create(:user)
      expect { create(:like, user: new_user, likeable: post) }.to change { post.reload.likes_count }.by(1)
    end

    it 'updates the likeable likes_count after destroy' do
      like = create(:like, user: user, likeable: post)
      expect { like.destroy }.to change { post.reload.likes_count }.by(-1)
    end
  end
end
