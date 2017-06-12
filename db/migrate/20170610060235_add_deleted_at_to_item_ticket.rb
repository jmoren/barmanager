class AddDeletedAtToItemTicket < ActiveRecord::Migration
  def change
    add_column :item_tickets, :deleted_at, :datetime
    add_index :item_tickets, :deleted_at
  end
end
