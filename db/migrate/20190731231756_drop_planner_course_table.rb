class DropPlannerCourseTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :course_planners
  end
end
