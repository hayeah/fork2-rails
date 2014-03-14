class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :short_id, :null => false
      t.string :commit
      t.string :git_url, :null => false

      t.timestamps
    end

    add_index :courses, :short_id, unique: true

    create_table :lessons do |t|
      t.integer :course_id, :null => false
      t.string :short_id, :null => false

      t.string :commit, :limit => 40

      t.string :title
      t.text :intro
      t.text :content

      t.boolean :deleted, :default => false

      t.timestamps
    end

    add_index :lessons, [:course_id,:short_id], :unique => true
    add_index :lessons, :short_id
  end
end
