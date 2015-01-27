class RemoveNumberToTable < ActiveRecord::Migration
  def change
    remove_column    :tables, :number
  end
end
