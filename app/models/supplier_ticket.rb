class SupplierTicket < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :shift
end
