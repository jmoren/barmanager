class AddPolimorficRelationToExpenses < ActiveRecord::Migration
  def change
    rename_column :expenses, :shift_id, :shift_or_daily_cash_id
    add_column :expenses, :shift_or_daily_cash_type, :string, default: :Shift
  end
end
