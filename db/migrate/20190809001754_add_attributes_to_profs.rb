class AddAttributesToProfs < ActiveRecord::Migration[6.0]
  def change
    add_column :profs, :name, :string
    add_column :profs, :rating, :decimal, :precision => 1, :scale => 1
    add_column :profs, :num_ratings, :integer
    add_column :profs, :tid, :integer
  end
end
