class CreateSelectors < ActiveRecord::Migration[6.0]
  def change
    create_table :selectors do |t|

      t.timestamps
    end
  end
end
