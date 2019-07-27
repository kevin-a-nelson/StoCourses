class RemoveCreditsFromCourse < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :credits, :string
  end
end
