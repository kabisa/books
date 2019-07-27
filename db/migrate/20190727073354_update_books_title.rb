class UpdateBooksTitle < ActiveRecord::Migration[6.0]
  def change
    change_column(:books, :title, :string, limit: 255)
  end
end
