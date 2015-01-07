class AddCodeToPromotions < ActiveRecord::Migration
  def change
    add_column    :promotions, :code, :integer
     add_index    :promotions, :code, :unique => true
  end
end