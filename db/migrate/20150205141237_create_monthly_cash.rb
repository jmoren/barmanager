class CreateMonthlyCash < ActiveRecord::Migration
  def change
    create_table :monthly_cashes do |t|
      t.float :total
      t.boolean :close
      t.date :date

      t.timestamps
    end
  end
end
