class AddSupplierToExpense < ActiveRecord::Migration
  def change
    add_reference :expenses, :supplier, index: true
  end
end
