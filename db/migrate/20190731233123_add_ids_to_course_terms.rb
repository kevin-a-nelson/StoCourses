class AddIdsToCourseTerms < ActiveRecord::Migration[6.0]
  def change
    add_column :course_terms, :course_id, :integer
    add_column :course_terms, :term_id, :integer
  end
end
