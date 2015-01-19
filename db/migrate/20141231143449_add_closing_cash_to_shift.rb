class AddClosingCashToShift < ActiveRecord::Migration
  def change
    remove_column :shifts, :money
    add_column :shifts, :closing_cash, :float
    add_column :shifts, :opening_cash, :float
  end
end
