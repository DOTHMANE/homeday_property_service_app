class CreateProperties < ActiveRecord::Migration[7.2]
  def change
    create_table :properties do |t|
      t.string :house_number
      t.string :street
      t.string :city
      t.integer :zip_code
      t.string :state
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :property_type, null: false
      t.string :marketing_type, null: false
      t.integer :price
      t.timestamps
    end
  end
end
