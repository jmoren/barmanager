class AddStatusToTables < ActiveRecord::Migration
  def change
    add_column :tables, :status, :string
  end
end
