class CreateAdditionals < ActiveRecord::Migration
  def change
    create_table :additionals do |t|
      t.string :description
      t.float :amount
      t.references :ticket, index: true
    end
  end
end
