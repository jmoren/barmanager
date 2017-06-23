class AddIndexToItemTickets < ActiveRecord::Migration
  def change
    add_index :item_tickets, :delivered
    add_index :promotion_ticket_items, :delivered
    add_index :promotion_ticket_items, :id
    add_index :promotion_ticket_items, :promotion_ticket_id
    add_index :items, :id
    add_index :items, :category_id
    add_index :categories, :kitchen
    add_index :categories, :id
  end
end
