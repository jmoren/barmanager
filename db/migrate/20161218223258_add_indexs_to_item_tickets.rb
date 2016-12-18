class AddIndexsToItemTickets < ActiveRecord::Migration
  def up
    add_index(:item_tickets, :ticket_id)
    add_index(:item_tickets, :item_id)
  end

  def down
    remove_index(:item_tickets, :ticket_id)
    remove_index(:item_tickets, :item_id)
  end
end
