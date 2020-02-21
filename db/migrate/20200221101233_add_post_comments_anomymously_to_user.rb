class AddPostCommentsAnomymouslyToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :comments_anonymously, :boolean, default: false
  end
end
