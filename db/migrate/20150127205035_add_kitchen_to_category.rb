class AddKitchenToCategory < ActiveRecord::Migration
  def change
    add_column    :categories, :kitchen, :boolean, default: false
  end
end
