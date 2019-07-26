class RemoveTypeFromCourse < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :type
  end
end
