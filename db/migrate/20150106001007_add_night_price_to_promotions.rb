class AddNightPriceToPromotions < ActiveRecord::Migration
  def change
    add_column    :promotions, :night_price, :float
    rename_column :promotions, :price, :day_price
  end
end