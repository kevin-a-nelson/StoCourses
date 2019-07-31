class CreateCoursePlanners < ActiveRecord::Migration[6.0]
  def change
    create_table :course_planners do |t|
      t.integer :course_id
      t.integer :planner_id

      t.timestamps
    end
  end
end
