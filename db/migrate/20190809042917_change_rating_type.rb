class ChangeRatingType < ActiveRecord::Migration[6.0]
  def change
    remove_column :profs, :rating
    add_column :profs, :rating, :string
  end
end
