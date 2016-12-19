class AddIndexesOnTables < ActiveRecord::Migration
    def up
    add_index(:tables, :id)
    add_index(:tables, :status)
    add_index(:tables, :description)
    add_index(:clients, :name)
  end

  def down
    remove_index(:tables, :id)
    remove_index(:tables, :status)
    remove_index(:tables, :description)
    remove_index(:clients, :name)
  end
end
