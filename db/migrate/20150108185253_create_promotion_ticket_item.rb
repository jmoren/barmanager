class CreatePromotionTicketItem < ActiveRecord::Migration
  def change
    create_table :promotion_ticket_items do |t|
      t.references :promotion_ticket
      t.references :promotion_item, index: true
      t.integer :delivered, default: 0
    end
  end
end
