class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, limit: 255
      t.string :name, limit: 100
      t.string :login_token
      t.datetime :login_token_valid_until

      t.timestamps
    end
  end
end
