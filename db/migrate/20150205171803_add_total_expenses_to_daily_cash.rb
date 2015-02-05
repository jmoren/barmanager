class AddTotalExpenseToDailyCash < ActiveRecord::Migration
  def change
    add_column :daily_cashes, :total_expenses, :float
  end
end
