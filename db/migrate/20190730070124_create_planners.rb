class CreatePlanners < ActiveRecord::Migration[6.0]
  def change
    create_table :planners do |t|
      t.string :name
      t.string :year
      t.string :semester

      t.timestamps
    end
  end
end
