class RemoveSemesterAndYearFromTerm < ActiveRecord::Migration[6.0]
  def change
    remove_column :terms, :semester
    remove_column :terms, :year
    add_column :terms, :term, :integer
  end
end
