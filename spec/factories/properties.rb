# spec/factories/properties.rb
FactoryBot.define do
  factory :property do
    latitude { 37.7749 }
    longitude { -122.4194 }
    property_type { 'house' }
    marketing_type { 'sale' }

    # You can add other fields here if needed
  end
end