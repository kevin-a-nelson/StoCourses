class AddValuesToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :credits, :decimal, precision: 5, place: 2
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
    add_column :courses, :prerequisites, :string
    add_column :courses, :section, :string
    add_column :courses, :semester, :integer
    add_column :courses, :status, :string
    add_column :courses, :term, :integer
    add_column :courses, :type, :string
    add_column :courses, :year, :integer
  end
end
