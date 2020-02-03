class AddReeditionToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :reedition, foreign_key: { to_table: :books }
  end
end
