# spec/requests/properties_spec.rb
require 'rails_helper'

RSpec.describe "Properties", type: :request do
  let(:property_params) do
    {
      lat: 37.7749,
      lng: -122.4194,
      property_type: 'house',
      marketing_type: 'sale'
    }
  end

  let!(:property_1) { create(:property, latitude: 37.7749, longitude: -122.4194, property_type: 'house', marketing_type: 'sale') }
  let!(:property_2) { create(:property, latitude: 37.7750, longitude: -122.4195, property_type: 'house', marketing_type: 'sale') }
  let!(:property_3) { create(:property, latitude: 40.7128, longitude: -74.0060, property_type: 'apartment', marketing_type: 'rent') }

  describe 'GET /properties/similar' do
    context 'when valid parameters are provided' do
      before do
        allow_any_instance_of(PropertyService).to receive(:similar_properties).and_return(Property.where(id: property_2.id))
        get '/properties/similar', params: property_params
      end

      it 'returns a list of similar properties' do
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['properties'].size).to eq(1)
      end
    end

    context 'when no properties are found' do
      before do
        allow_any_instance_of(PropertyService).to receive(:similar_properties).and_return(Property.none)
        get '/properties/similar', params: property_params
      end

      it 'returns a not found error' do
        expect(response.status).to eq(404)
        expect(JSON.parse(response.body)['error']).to eq('No properties found')
      end
    end

    context 'when invalid parameters are provided' do
      before do
        allow(PropertyService).to receive(:new).and_raise(ArgumentError.new('Invalid parameters'))
        get '/properties/similar', params: property_params
      end

      it 'returns an error message' do
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['errors']).to include('Invalid parameters')
      end
    end

    context 'when an unexpected error occurs' do
      before do
        allow(PropertyService).to receive(:new).and_raise(StandardError.new('Unexpected error'))
        get '/properties/similar', params: property_params
      end

      it 'returns a 500 internal server error' do
        expect(response.status).to eq(500)
        expect(JSON.parse(response.body)['error']).to eq('Something went wrong: Unexpected error')
      end
    end
  end
end



