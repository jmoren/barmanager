class AddPendingTotalAndPendingCancelationToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :pending, :float, default: 0
    add_column :shifts, :payments, :float, default: 0
  end
end
