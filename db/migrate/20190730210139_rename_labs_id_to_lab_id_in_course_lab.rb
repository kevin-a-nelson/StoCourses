class RenameLabsIdToLabIdInCourseLab < ActiveRecord::Migration[6.0]
  def change
    remove_column :course_labs, :labs_id
    add_column :course_labs, :lab_id, :integer
  end
end
