class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.string :type
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end

    add_column :books, :likes_count, :integer, default: 0
    add_column :books, :dislikes_count, :integer, default: 0
  end
end
