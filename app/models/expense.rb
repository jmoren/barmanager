class Expense < ActiveRecord::Base
  belongs_to :shift
  
  validates :description, :amount, :shift_id, presence: true
end
