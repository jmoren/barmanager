class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :description
      t.float :amount
      t.references :shift, index: true
    end
  end
end
