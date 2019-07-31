class AddValuesToCourseLab < ActiveRecord::Migration[6.0]
  def change
    create_table :course_labs do |t|
      t.integer "lab_id"
      t.integer "course_id"
      t.timestamps
    end
  end
end
