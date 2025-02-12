# spec/models/property_spec.rb
require 'rails_helper'

RSpec.describe Property, type: :model do
  subject { build(:property) }

  describe 'validations' do
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:property_type) }
    it { should validate_presence_of(:marketing_type) }

    it { should validate_numericality_of(:latitude).is_greater_than_or_equal_to(-90).is_less_than_or_equal_to(90) }
    it { should validate_numericality_of(:longitude).is_greater_than_or_equal_to(-180).is_less_than_or_equal_to(180) }
  end

  describe '.similar_in_radius' do
    let!(:property_1) { create(:property, latitude: 37.7749, longitude: -122.4194, property_type: 'house', marketing_type: 'sale') }
    let!(:property_2) { create(:property, latitude: 37.7750, longitude: -122.4195, property_type: 'house', marketing_type: 'sale') }
    let!(:property_3) { create(:property, latitude: 40.7128, longitude: -74.0060, property_type: 'apartment', marketing_type: 'rent') }
    let(:property_4) { build(:property, latitude: 40.7128, longitude: -74.0060, property_type: 'villa', marketing_type: 'rent') }

    it 'returns similar properties within the specified radius' do
      similar_properties = Property.similar_in_radius(property_1, 100)
      expect(similar_properties).to include(property_2)
      expect(similar_properties).not_to include(property_3)
    end

    it 'returns no properties if none are within the specified radius' do
      similar_properties = Property.similar_in_radius(property_4, 1)
      expect(similar_properties).to be_empty
    end
  end
end
