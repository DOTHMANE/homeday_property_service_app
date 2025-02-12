class PropertiesController < ApplicationController
  def similar
    property_service = PropertyService.new(
      lat: properties_params[:lat],
      lng: properties_params[:lng],
      property_type: properties_params[:property_type],
      marketing_type: properties_params[:marketing_type]
    )

    similar_properties = property_service.similar_properties

    if similar_properties.any?
      render json: { properties: similar_properties }, status: :ok
    else
      render json: { error: "No properties found" }, status: :not_found
    end
  rescue ArgumentError => e
    render json: { errors: e.message.split(", ") }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
  end

  private

  def properties_params
    params.permit(:lat, :lng, :property_type, :marketing_type)
  end
end
