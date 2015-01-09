class RemoveStockToItems < ActiveRecord::Migration
  def change
    remove_column :items, :stock
  end
end
