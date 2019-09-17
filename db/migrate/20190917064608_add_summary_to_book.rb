class AddSummaryToBook < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :summary, :string, limit: 2048
  end
end
