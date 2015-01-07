class Shift < ActiveRecord::Base
  has_many :tickets
  has_many :expenses

  validates :opening_cash, presence: true
  validates :opening_cash, numericality: true, on: :create
  validates :closing_cash, numericality: true, on: :update

  def is_open?
    self.close.nil?
  end

  def has_open_tables?
    Table.where(status: :open).count > 0
  end

  def total_expenses
    expenses.sum(:amount).to_f
  end

  def total_tickets
    tickets.sum(:total).to_f
  end

  def count_items
    items = ItemTicket.where(ticket_id: self.tickets.map(&:id))
    by_items = {}
    items.each do |it|
      item = it.item
      by_items[item.description] = { total: 0, subtotal: 0 } if by_items[item.description].nil?
      by_items[item.description][:total]    += it.quantity
      by_items[item.description][:subtotal] += it.sub_total
    end

    by_items
  end

  def add_closed_data
    self.closing_cash = self.total_tickets - self.total_expenses + self.opening_cash
    self.close = DateTime.now
  end

  def self.last_open
    if Shift.last && Shift.last.is_open?
      Shift.last
    else
      nil
    end
  end
end
