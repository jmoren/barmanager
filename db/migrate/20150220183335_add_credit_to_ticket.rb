class AddCreditToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :credit, :boolean, default: false
  end
end
