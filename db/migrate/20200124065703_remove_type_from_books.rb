class RemoveTypeFromBooks < ActiveRecord::Migration[6.0]
  def change

    remove_column :books, :type, :string
  end
end
