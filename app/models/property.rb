class Property < ApplicationRecord
  # Validations related to property fields
  validates :latitude, :longitude, :property_type, :marketing_type, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

end
