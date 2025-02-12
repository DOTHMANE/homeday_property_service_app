class AddEarthLocationToProperties < ActiveRecord::Migration[7.2]
  def change
    add_column :properties, :earth_location, 'earth'
  end
end
