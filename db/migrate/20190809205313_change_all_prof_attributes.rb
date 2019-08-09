class ChangeAllProfAttributes < ActiveRecord::Migration[6.0]
  def change
    remove_column :profs, :name
    remove_column :profs, :num_ratings
    remove_column :profs, :rating
    remove_column :profs, :tid

    add_column :profs, :department, :string
    add_column :profs, :fName, :string
    add_column :profs, :lName, :string
    add_column :profs, :tid, :string
    add_column :profs, :num_ratings, :string
    add_column :profs, :overall_ratings, :string
  end
end
