class ChangeTidToInt < ActiveRecord::Migration[6.0]
  def change
    remove_column :profs, :tid
    add_column :profs, :tid, :integer
  end
end
