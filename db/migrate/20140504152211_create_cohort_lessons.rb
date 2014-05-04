class CreateCohortLessons < ActiveRecord::Migration
  def change
    create_table :cohort_lessons do |t|
      t.integer :cohort_id, :null => false
      t.string :permalink, :null => false
      t.string :discourse_thread_url
      t.integer :position
    end

    add_index :cohort_lessons, :cohort_id
    add_index :cohort_lessons, [:permalink,:cohort_id], :unique => true
  end
end
