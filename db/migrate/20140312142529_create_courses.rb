class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :duration, :default => 7, :null => false
      t.string :short_id, :null => false
      t.string :commit
      t.string :repo, :null => false
      t.text :schedule, :array => true

      t.timestamps
    end

    add_index :courses, :short_id, unique: true
  end
end
