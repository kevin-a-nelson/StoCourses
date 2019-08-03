class DropPlannerTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :planners
  end
end
