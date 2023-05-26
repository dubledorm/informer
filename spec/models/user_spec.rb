require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory' do
    let!(:user) { FactoryBot.create :user }
    let!(:user_admin) { FactoryBot.create :user_admin }

    # Factories
    it { expect(user).to be_valid }
    it { expect(user_admin).to be_valid }
  end

  describe 'admin' do
    it { expect(User.new.admin).to be_falsey }
  end
end
