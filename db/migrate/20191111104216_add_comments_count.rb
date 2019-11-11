class AddCommentsCount < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :comments_count, :integer, default: 0

    Book.reset_column_information
    Book.all.each do |b|
      Book.update_counters b.id, comments_count: b.comments.length
    end
  end
end
