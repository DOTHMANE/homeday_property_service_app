# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
json_file = Rails.root.join('data', 'properties.json')

def calculate_earth_location(lat, lng)
  Arel.sql("ll_to_earth(#{lat}, #{lng})") if lat.present? && lng.present?
end
def import_json_file(file)
  properties = JSON.parse(File.read(file))

  Property.transaction do
    properties.each_slice(500) do |batch|
      property_records = batch.map do |row|
        {
          house_number: row["house_number"],
          street: row["street"],
          city: row["city"],
          zip_code: row["zip_code"],
          state: row["state"],
          latitude: row["lat"],
          longitude: row["lng"],
          earth_location: calculate_earth_location(row["lat"], row["lng"]),
          property_type: row["property_type"],
          marketing_type: row["marketing_type"],
          price: row["price"]
        }
      end
      Property.insert_all(property_records) # Efficient batch insert
    end
  end

  puts "Seeding complete."
end

if File.exist?(json_file)
  puts "Seeding database from JSON file..."
  import_json_file(json_file)
else
  puts "JSON file not found. Skipping seed import."
end

