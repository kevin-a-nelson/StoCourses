class RenameSessionTypeInCourses < ActiveRecord::Migration[6.0]
  def change
    rename_column :courses, :session_type, :course_type
  end
end
