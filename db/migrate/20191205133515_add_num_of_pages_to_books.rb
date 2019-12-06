class AddNumOfPagesToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :num_of_pages, :integer, limit: 2
  end
end
