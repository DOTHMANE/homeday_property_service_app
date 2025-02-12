class AddIndexToProperties < ActiveRecord::Migration[7.2]
  def change
    add_index :properties, [:property_type, :marketing_type]
  end
end
