class CreateJoinTableBookWriter < ActiveRecord::Migration[6.0]
  def change
    create_join_table :books, :writers do |t|
      # t.index [:book_id, :writer_id]
      # t.index [:writer_id, :book_id]
    end
  end
end
