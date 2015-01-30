class CreateDailyCashes < ActiveRecord::Migration
  def change
    create_table :daily_cashes do |t|
      t.integer :total
      t.boolean :close, default: false

      t.timestamps
    end
  end
end
