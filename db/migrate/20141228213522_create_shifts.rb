class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.datetime :open
      t.datetime :close

      t.timestamps
    end
  end
end
