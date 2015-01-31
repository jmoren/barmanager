class DailyCash < ActiveRecord::Base

  def self.last_closed
    DailyCash.where(close: true).order(date: :desc).first
  end
end
