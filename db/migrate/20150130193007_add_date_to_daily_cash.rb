class AddDateToDailyCash < ActiveRecord::Migration
  def change
    add_column    :daily_cashes, :date, :date
  end
end
