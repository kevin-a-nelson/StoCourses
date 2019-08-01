class CreateRemoveSemesterAndYearFromPlanners < ActiveRecord::Migration[6.0]
  def change
    remove_column :planners, :semester
    remove_column :planners, :year
  end
end
