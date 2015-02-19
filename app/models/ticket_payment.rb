class TicketPayment < ActiveRecord::Base
  belongs_to :client
  belongs_to :shift
end
