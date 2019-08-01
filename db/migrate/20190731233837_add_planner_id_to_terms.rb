class AddPlannerIdToTerms < ActiveRecord::Migration[6.0]
  def change
    add_column :terms, :planner_id, :integer
  end
end
