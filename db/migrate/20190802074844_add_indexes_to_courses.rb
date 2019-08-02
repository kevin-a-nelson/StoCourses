class AddIndexesToCourses < ActiveRecord::Migration[6.0]
  def change
    add_index :courses, :term
  end
end
