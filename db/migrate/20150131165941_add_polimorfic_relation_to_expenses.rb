class AddPolimorficRelationToExpenses < ActiveRecord::Migration
  def change
    rename_column :expenses, :shift_id, :shift_or_user_id
    add_column :expenses, :shift_or_user_type, :string, default: :Shift
  end
end
