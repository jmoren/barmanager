class AddDescriptionToTables < ActiveRecord::Migration
  def change
    add_column :tables, :description, :string
  end
end
