class AddNightPriceToItems < ActiveRecord::Migration
  def change
    add_column    :items, :night_price, :float
    rename_column :items, :price, :day_price
  end
end
