class CreateCourseLabs < ActiveRecord::Migration[6.0]
  def change
    create_table :course_labs do |t|

      t.timestamps
    end
  end
end
