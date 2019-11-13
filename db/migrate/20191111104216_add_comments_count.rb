class AddCommentsCount < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :comments_count, :integer, default: 0
  end
end
