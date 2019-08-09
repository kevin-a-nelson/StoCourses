class AddIndexToCourseTerms < ActiveRecord::Migration[6.0]
  def change
    add_index :course_terms, [:course_id, :term_id], unique: true
  end
end
