class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.float :price
      t.integer :stock
      t.integer :category_id

      t.timestamps
    end
  end
end
