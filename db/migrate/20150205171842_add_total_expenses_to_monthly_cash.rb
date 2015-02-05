class AddTotalExpenseToMonthlyCash < ActiveRecord::Migration
  def change
    add_column :monthly_cashes, :total_expenses, :float
  end
end
