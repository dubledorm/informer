require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'factory' do
    let!(:location) { FactoryBot.create :location }

    # Factories
    it { expect(location).to be_valid }

    # Validations
    it { should validate_presence_of(:russian_name) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }

    it { expect(FactoryBot.build(:location, lat: 'something')).to_not be_valid }
    it { expect(FactoryBot.build(:location, lon: 'something')).to_not be_valid }
  end
end
