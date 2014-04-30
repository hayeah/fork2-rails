class AddUserDiscourseUsername < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :discourse_username
    end
  end
end
