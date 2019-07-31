class AddIdsToCourseLabs < ActiveRecord::Migration[6.0]
  def change
    add_column :course_labs, :course_id, :integer
    add_column :course_labs, :labs_id, :integer
  end
end
