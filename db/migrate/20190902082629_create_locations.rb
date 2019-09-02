class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :city, limit: 255

      t.timestamps
    end
  end
end
