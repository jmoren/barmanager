class CreateExtraction < ActiveRecord::Migration
  def change
    create_table :extractions do |t|
      t.integer :amount
      t.string :description
      t.references :shift, index: true
    end
  end
end
