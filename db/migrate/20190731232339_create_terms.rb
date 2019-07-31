class CreateTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :terms do |t|
      t.integer :year
      t.integer :semester

      t.timestamps
    end
  end
end
