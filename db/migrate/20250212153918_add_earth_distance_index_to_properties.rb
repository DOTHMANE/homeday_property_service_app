class AddEarthDistanceIndexToProperties < ActiveRecord::Migration[7.2]
  def change
    add_index :properties, "(ll_to_earth(latitude, longitude))", using: :gist
  end
end
