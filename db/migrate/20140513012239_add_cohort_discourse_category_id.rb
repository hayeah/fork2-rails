class AddCohortDiscourseCategoryId < ActiveRecord::Migration
  def change
    add_column(:cohorts,:discourse_category_name,:string)
  end
end
