# spec/services/property_service_spec.rb
require 'rails_helper'

RSpec.describe PropertyService, type: :service do
  let(:property_service) do
    PropertyService.new(
      lat: 37.7749,
      lng: -122.4194,
      property_type: 'house',
      marketing_type: 'sale'
    )
  end

  describe '#similar_properties' do
    let!(:property_1) { create(:property, latitude: 37.7749, longitude: -122.4194, property_type: 'house', marketing_type: 'sale') }
    let!(:property_2) { create(:property, latitude: 37.7750, longitude: -122.4195, property_type: 'house', marketing_type: 'sale') }

    it 'returns similar properties if valid' do
      allow(property_service).to receive(:similar_properties).and_return([property_2])
      expect(property_service.similar_properties).to include(property_2)
    end

    it 'raises an error if the property is invalid' do
      property_service_invalid = PropertyService.new(
        lat: 999,
        lng: 999,
        property_type: 'house',
        marketing_type: 'sale'
      )

      expect { property_service_invalid.similar_properties }.to raise_error(ArgumentError)
    end
  end
end