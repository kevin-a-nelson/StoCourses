class RemoveTypesInCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :type
    add_column :courses, :session_type, :string
  end
end
