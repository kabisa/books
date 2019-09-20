class AddDeletedAtToBorrowings < ActiveRecord::Migration[6.0]
  def change
    add_column :borrowings, :deleted_at, :datetime
    add_index :borrowings, :deleted_at
  end
end
