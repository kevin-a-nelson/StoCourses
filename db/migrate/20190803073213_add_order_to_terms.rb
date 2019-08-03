class AddOrderToTerms < ActiveRecord::Migration[6.0]
  def change
    add_column :terms, :order, :integer
  end
end
