class AddDeliveredToItemTicket < ActiveRecord::Migration
  def change
    add_column    :item_tickets, :delivered, :boolean, default: false
  end
end
