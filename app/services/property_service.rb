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

    Property.similar_in_radius(@property, @radius)
  end
end