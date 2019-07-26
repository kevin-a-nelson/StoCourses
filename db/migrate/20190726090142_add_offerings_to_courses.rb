class AddOfferingsToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :offerings, :string
  end
end
