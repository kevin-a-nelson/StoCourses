class ChangeCreditsToDemical < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :credits
    add_column :courses, :credits, :decimal, precision: 5, scale: 2
  end
end
