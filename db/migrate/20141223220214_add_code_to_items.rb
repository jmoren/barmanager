class AddCodeToItems < ActiveRecord::Migration
  def change
    add_column :items, :code, :integer
  end
end
