class AddDescriptionToSupplierTickets < ActiveRecord::Migration
  def change
    add_column :supplier_tickets, :description, :string
  end
end
