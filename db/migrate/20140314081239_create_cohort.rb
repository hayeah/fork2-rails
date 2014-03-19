class CreateCohort < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.references :course, :null => false
      t.string :short_id, :null => false
      t.integer :total_days, :null => false
      t.integer :current_day, :default => 0

      t.json :schedule

      t.timestamps
    end

    add_index :cohorts, :short_id, :unique => true

    create_table :cohort_users do |t|
      t.references :cohort, :null => false
      t.references :user, :null => false
    end
  end
end
