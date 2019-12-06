class AddPublishedOnToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :published_on, :date
  end
end
