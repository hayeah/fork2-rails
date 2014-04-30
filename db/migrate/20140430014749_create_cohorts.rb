class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :permalink, :null => false
    end

    add_index :cohorts, :permalink, :unique => true
  end
end
