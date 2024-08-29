require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liking_users).through(:likes).source(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_length_of(:content).is_at_most(160) }

  describe 'default scope' do
    it 'orders by created_at desc' do
      user = create(:user)
      older_post = create(:post, user: user, created_at: 1.day.ago)
      newer_post = create(:post, user: user, created_at: Time.now)

      expect(Post.all).to eq([newer_post, older_post])
    end
  end
end
