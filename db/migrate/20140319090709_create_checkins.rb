class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :cohort_user, :null => false
      t.references :lesson, :null => false
      t.float :time_spent
      t.integer :difficulty
      t.text :feedback
      t.timestamps
    end

    add_index :checkins, [:cohort_user_id,:lesson_id], :unique => true
  end
end
