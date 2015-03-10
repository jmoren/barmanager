class CreateSupplierTickets < ActiveRecord::Migration
  def change
    create_table :supplier_tickets do |t|
      t.float :amount
      t.references :supplier, index: true
      t.references :shift, index: true

      t.timestamps
    end
  end
end
