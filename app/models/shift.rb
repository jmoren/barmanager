class Shift < ActiveRecord::Base
  has_many :tickets

  validates :opening_cash, presence: true
  validates :opening_cash, numericality: true, on: :create
  validates :closing_cash, numericality: true, on: :update

  def is_open?
    self.close.nil?
  end

  def self.last_open
    return Shift.last if Shift.last && Shift.last.is_open?
  end
end
