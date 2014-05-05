class CreateTestReports < ActiveRecord::Migration
  def change
    create_table :test_reports do |t|
      t.integer :user_id, :null => false
      t.string :project, :null => false
      t.string :suite, :null => false
      t.string :section
      t.integer :code, :null => false
      t.timestamp :created_at
      t.text :stdout
    end

    add_index :test_reports, :user_id
  end
end
