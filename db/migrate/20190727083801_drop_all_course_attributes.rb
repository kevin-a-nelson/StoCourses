class DropAllCourseAttributes < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :department
    remove_column :courses, :description
    remove_column :courses, :enrolled
    remove_column :courses, :gereqs
    remove_column :courses, :instructors
    remove_column :courses, :level
    remove_column :courses, :max
    remove_column :courses, :name
    remove_column :courses, :notes
    remove_column :courses, :number
    remove_column :courses, :prerequisites
    remove_column :courses, :section
    remove_column :courses, :semester
    remove_column :courses, :status
    remove_column :courses, :term
    remove_column :courses, :year
    remove_column :courses, :offerings
  end
end
