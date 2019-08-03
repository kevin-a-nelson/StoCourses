class LinkTermAndUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :terms, :planner_id
    add_column :terms, :user_id, :integer
  end
end
