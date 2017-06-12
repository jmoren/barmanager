class AddPrintedAtToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :printed_at, :datetime
    add_index :tickets, :printed_at
  end
end
