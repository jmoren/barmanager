class AddShiftToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :shift, index: true
  end
end
