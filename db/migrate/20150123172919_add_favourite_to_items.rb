class AddFavouriteToItems < ActiveRecord::Migration
  def change
    add_column    :items, :favourite, :boolean, default: false
  end
end
