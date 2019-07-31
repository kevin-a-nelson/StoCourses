class RemoveTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :labs
    drop_table :course_labs
    drop_table :selectors
  end
end
