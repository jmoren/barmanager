class AddDeletedAtPromotionTicket < ActiveRecord::Migration
  def change
    add_column :promotion_tickets, :deleted_at, :datetime
    add_index :promotion_tickets, :deleted_at
  end
end
