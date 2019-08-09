class CamelCaseProfs < ActiveRecord::Migration[6.0]
  def change
    rename_column :profs, :fName, :f_name
    rename_column :profs, :lName, :l_name
  end
end
