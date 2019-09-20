class AddDeletedAtToCopies < ActiveRecord::Migration[6.0]
  def change
    add_column :copies, :deleted_at, :datetime
    add_index :copies, :deleted_at
  end
end
