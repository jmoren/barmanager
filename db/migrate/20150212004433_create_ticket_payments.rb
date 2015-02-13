class CreateTicketPayments < ActiveRecord::Migration
  def change
    create_table :ticket_payments do |t|
      t.references :ticket, index: true
      t.float :amount

      t.timestamps
    end
  end
end
