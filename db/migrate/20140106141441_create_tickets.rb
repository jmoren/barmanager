class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :trend_id
      t.integer :table_id
      t.datetime :date
      t.float :total
      t.integer :payment

      t.timestamps
    end
  end
end
