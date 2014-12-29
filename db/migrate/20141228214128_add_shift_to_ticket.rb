class AddShiftToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :Shift, index: true
  end
end
