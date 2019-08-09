class RenameProfsOverRatings < ActiveRecord::Migration[6.0]
  def change
    rename_column :profs, :overall_rating, :rating 
  end
end
