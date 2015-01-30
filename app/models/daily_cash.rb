class DailyCash < ActiveRecord::Base
  has_many :expenses, as: :shift_or_daily_cash

  def total_expenses
    expenses.sum(:amount)
  end
end
