class AddUniqueIndexesToCourseProfs < ActiveRecord::Migration[6.0]
  def change
    add_index :course_profs, [:course_id, :prof_id], unique: true
  end
end
