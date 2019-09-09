class CreateBorrowings < ActiveRecord::Migration[6.0]
  def change
    create_table :borrowings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :copy, null: false, foreign_key: true
      t.timestamp :borrowed_at

      t.timestamps
    end
  end
end
