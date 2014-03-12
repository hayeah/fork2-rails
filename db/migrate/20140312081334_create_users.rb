class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_id, :null => false
      t.json :github_data

      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :users, :github_id, unique: true
  end
end
