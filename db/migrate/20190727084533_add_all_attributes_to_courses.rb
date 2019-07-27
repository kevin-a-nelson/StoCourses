class AddAllAttributesToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :clbid, :string
    add_column :courses, :credits, :decimal, precision: 5, place: 2
    add_column :courses, :crsid, :string
    add_column :courses, :department, :string
    add_column :courses, :description, :text
    add_column :courses, :enrolled, :integer
    add_column :courses, :gereqs, :string
    add_column :courses, :instructors, :string
    add_column :courses, :level, :integer
    add_column :courses, :max, :integer
    add_column :courses, :name, :string
    add_column :courses, :notes, :text
    add_column :courses, :number, :integer
    add_column :courses, :offerings, :string
    add_column :courses, :pn, :boolean
    add_column :courses, :prerequisites, :string
    add_column :courses, :revisions, :text
    add_column :courses, :section, :string
    add_column :courses, :semester, :integer
    add_column :courses, :status, :string
    add_column :courses, :term, :integer
    add_column :courses, :type, :string
    add_column :courses, :year, :integer
    add_column :courses, :days, :string
    add_column :courses, :times, :string
    add_column :courses, :location, :string
    add_column :courses, :firstyear, :boolean
    add_column :courses, :sophmore, :boolean
    add_column :courses, :junior, :boolean
    add_column :courses, :senior, :boolean
  end
end
