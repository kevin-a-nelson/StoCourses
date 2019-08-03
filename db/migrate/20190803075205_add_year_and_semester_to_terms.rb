class AddYearAndSemesterToTerms < ActiveRecord::Migration[6.0]
  def change
    add_column :terms, :semester, :integer
    add_column :terms, :year, :integer
  end
end
