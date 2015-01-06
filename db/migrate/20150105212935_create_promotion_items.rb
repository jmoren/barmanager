class CreatePromotionItems < ActiveRecord::Migration
  def change
    create_table :promotion_items do |t|
      t.references :item
      t.references :promotion
      t.integer :quantity

      t.timestamps
    end
  end
end
