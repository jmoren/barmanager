class AddNumberToSupplierTickets < ActiveRecord::Migration
  def change
    add_column :supplier_tickets, :code_number, :integer
  end
end
