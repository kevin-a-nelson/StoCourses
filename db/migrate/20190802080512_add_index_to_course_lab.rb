class AddIndexToCourseLab < ActiveRecord::Migration[6.0]
  def change
    add_index :course_labs, [:course_id, :lab_id], unique: true
  end
end
