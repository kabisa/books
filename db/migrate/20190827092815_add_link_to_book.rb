class AddLinkToBook < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :link, :string, limit: 2048
  end
end
