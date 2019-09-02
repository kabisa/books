class CreateCopies < ActiveRecord::Migration[6.0]
  def change
    create_table :copies do |t|
      t.references :book, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
