class RemoveCohortsFromCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :firstyear
    remove_column :courses, :sophmore
    remove_column :courses, :junior
    remove_column :courses, :senior
  end
end
