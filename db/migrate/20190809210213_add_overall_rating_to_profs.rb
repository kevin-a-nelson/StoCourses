class AddOverallRatingToProfs < ActiveRecord::Migration[6.0]
  def change
    add_column :profs, :overall_rating, :string
  end
end
