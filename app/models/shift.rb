class Shift < ActiveRecord::Base
  has_many :tickets

  validates :opening_cash, presence: true
  validates :opening_cash, numericality: true, on: :create
  validates :closing_cash, numericality: true, on: :update

  def is_open?
    self.close.nil?
  end

  def has_open_tables?
    Table.where(status: :open).count > 0
  end
  def self.last_open
    if Shift.last && Shift.last.is_open?
      Shift.last
    else
      nil
    end
  end
end
