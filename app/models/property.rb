class Property < ApplicationRecord
  # Validations related to property fields
  validates :latitude, :longitude, :property_type, :marketing_type, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  after_save :set_earth_location

  scope :similar_in_radius, ->(property, radius) {
    where(property_type: property.property_type, marketing_type: property.marketing_type)
      .where("earth_location && earth_box(ll_to_earth(?, ?), ?)", property.latitude, property.longitude, radius)
      .where("earth_distance(ll_to_earth(?, ?), earth_location) <= ?", property.latitude, property.longitude, radius)
  }

  private

  # Method to set the earth_location based on latitude and longitude
  def set_earth_location
    result = ActiveRecord::Base.connection.execute("SELECT ll_to_earth(#{latitude}, #{longitude})")
    update_column(:earth_location, result.first['ll_to_earth'])
  end
end
