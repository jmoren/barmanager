class AddCodeToItems < ActiveRecord::Migration
  def change
    add_column :items, :code, :integer
    add_index :items, :code, :unique => true
  end
end
