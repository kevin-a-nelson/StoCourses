class CreateCourseProfs < ActiveRecord::Migration[6.0]
  def change
    create_table :course_profs do |t|
      t.integer :prof_id
      t.integer :course_id

      t.timestamps
    end
  end
end
