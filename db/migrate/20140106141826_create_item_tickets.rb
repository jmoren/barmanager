class CreateItemTickets < ActiveRecord::Migration
  def change
    create_table :item_tickets do |t|
      t.integer :ticket_id
      t.integer :item_id
      t.integer :quantity
      t.float :sub_total

      t.timestamps
    end
  end
end
