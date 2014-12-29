class AddMoneyToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :money, :double
  end
end
