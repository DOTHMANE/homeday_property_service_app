class PropertySerializer < ActiveModel::Serializer
  attributes :house_number, :street, :city, :zip_code, :state, :latitude, :longitude, :price
end
