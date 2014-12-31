class AddClosingCashToShift < ActiveRecord::Migration
  def change
    remove_column :shifts, :money
    add_column :shifts, :closing_cash, :double
    add_column :shifts, :opening_cash, :double
  end
end
