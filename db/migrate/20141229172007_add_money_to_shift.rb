class AddMoneyToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :money, :float
  end
end
