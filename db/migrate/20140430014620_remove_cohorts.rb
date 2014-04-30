class RemoveCohorts < ActiveRecord::Migration
  def up
    drop_table(:cohorts)
  end
end
