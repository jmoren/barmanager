class Expense < ActiveRecord::Base
  belongs_to :shift_or_daily_cash, polymorphic: true

  validates :description, :amount, :shift_or_daily_cash_id, presence: true
end
