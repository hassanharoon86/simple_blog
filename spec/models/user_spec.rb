require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts).dependent(:destroy) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }

  describe '#full_name' do
    it 'returns the full name of the user' do
      user = User.new(first_name: 'John', last_name: 'Doe')
      expect(user.full_name).to eq('John Doe')
    end
  end
end
