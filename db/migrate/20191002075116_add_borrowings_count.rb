class AddBorrowingsCount < ActiveRecord::Migration[6.0]
  def change
    add_column :copies, :borrowings_count, :integer, default: 0

    Copy.reset_column_information
    Copy.all.each do |c|
      Copy.update_counters c.id, borrowings_count: c.borrowings.length
    end
  end
end
