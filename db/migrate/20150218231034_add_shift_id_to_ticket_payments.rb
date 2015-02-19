class AddShiftIdToTicketPayments < ActiveRecord::Migration
  def change
    add_reference :ticket_payments, :shift, index: true
  end
end
