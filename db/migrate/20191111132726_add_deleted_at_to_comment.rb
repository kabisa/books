class AddDeletedAtToComment < ActiveRecord::Migration[6.0]
  def change
    Book.reset_column_information
    Book.all.each do |b|
      Book.update_counters b.id, comments_count: b.comments.length
    end

    add_column :comments, :deleted_at, :datetime
    add_index :comments, :deleted_at
  end
end
