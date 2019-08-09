class AddDificultyToProfs < ActiveRecord::Migration[6.0]
  def change
    add_column :profs, :difficulty, :string
  end
end
