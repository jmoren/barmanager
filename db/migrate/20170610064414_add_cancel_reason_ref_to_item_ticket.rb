class AddCancelReasonRefToItemTicket < ActiveRecord::Migration
  def change
    add_reference :item_tickets, :cancel_reason, index: true, foreign_key: true
  end
end
