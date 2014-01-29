class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :city
      t.string :country
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
