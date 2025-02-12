class PropertyService
  DEFAULT_RADIUS = 5000

  def initialize(lat:, lng:, property_type:, marketing_type:, radius: DEFAULT_RADIUS)
    @property = Property.new(
      latitude: lat,
      longitude: lng,
      property_type: property_type,
      marketing_type: marketing_type,
      )
    @radius = radius
  end

  def similar_properties
    raise ArgumentError, @property.errors.full_messages.join(", ") unless @property.valid?

    Property.where(property_type: @property.property_type, marketing_type: @property.marketing_type)
            .where("earth_distance(ll_to_earth(?, ?), ll_to_earth(latitude, longitude)) <= ?", @property.latitude, @property.longitude, @radius)
            .pluck(:street, :city, :zip_code, :state, :latitude, :longitude, :price)

  end
end