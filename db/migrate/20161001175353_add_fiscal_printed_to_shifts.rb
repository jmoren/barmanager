class AddFiscalPrintedToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :fiscal_printed, :boolean, default: false
  end
end
