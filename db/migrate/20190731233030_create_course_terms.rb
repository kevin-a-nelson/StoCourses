class CreateCourseTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :course_terms do |t|

      t.timestamps
    end
  end
end
