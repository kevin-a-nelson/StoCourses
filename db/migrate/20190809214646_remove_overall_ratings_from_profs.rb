class RemoveOverallRatingsFromProfs < ActiveRecord::Migration[6.0]
  def change
    remove_column :profs, :overall_ratings
  end
end
