class AddClientIdToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :client, index: true
  end
end
