class Property < ApplicationRecord
  # Validations related to property fields
  validates :latitude, :longitude, :property_type, :marketing_type, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  scope :similar_in_radius, ->(property, radius) {
    where(property_type: property.property_type, marketing_type: property.marketing_type)
      .where("earth_distance(ll_to_earth(?, ?), ll_to_earth(latitude, longitude)) <= ?", property.latitude, property.longitude, radius)
  }
end
