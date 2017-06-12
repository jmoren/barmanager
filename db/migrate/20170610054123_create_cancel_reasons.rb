class CreateCancelReasons < ActiveRecord::Migration
  def change
    create_table :cancel_reasons do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
