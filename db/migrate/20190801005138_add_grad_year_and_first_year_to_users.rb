class AddGradYearAndFirstYearToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :enrollment_year, :integer
  end
end
