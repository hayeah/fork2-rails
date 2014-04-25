class AddUserAuthToken < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :auth_token, :null => false, :default => ""
    end
  end
end
