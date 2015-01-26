class AddFavouriteToPromotions < ActiveRecord::Migration
  def change
    add_column    :promotions, :favourite, :boolean, default: false
  end
end
