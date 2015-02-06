class AddKitchenToAdditionals < ActiveRecord::Migration
  def change
    add_column :additionals, :kitchen, :boolean
    add_column :additionals, :delivered, :boolean, default: false
  end
end
