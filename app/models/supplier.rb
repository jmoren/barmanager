class Supplier < ActiveRecord::Base
  has_many :supplier_tickets
  has_many :expenses
end
