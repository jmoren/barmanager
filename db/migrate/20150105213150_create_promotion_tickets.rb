class CreatePromotionTickets < ActiveRecord::Migration
  def change
    create_table :promotion_tickets do |t|
      t.references :ticket
      t.references :promotion
      t.integer :quantity
      t.float :subtotal

      t.timestamps
    end
  end
end
