class MonthlyCash < ActiveRecord::Base

  def self.last_closed
    MonthlyCash.where(close: true).order(date: :desc).first
  end
end
