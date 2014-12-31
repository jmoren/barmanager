class RemoveTrendIdFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :trend_id
  end
end
