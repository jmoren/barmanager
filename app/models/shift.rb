class Shift < ActiveRecord::Base
  belongs_to :user
  has_many :tickets
  has_many :expenses, as: :shift_or_user
  has_many :extractions
  has_many :ticket_payments
  has_many :supplier_payments

  validates :opening_cash, presence: true
  validates :opening_cash, numericality: true, on: :create
  validates :closing_cash, numericality: true, on: :update

  # to use with cancan
  def active
    is_open?
  end

  def is_open?
    self.close.nil?
  end

  def has_open_tickets?
    Ticket.where(status: :open, shift_id: self.id).count > 0
  end

  def total_expenses
    expenses.sum(:amount).to_f
  end

  def total_extractions
    extractions.sum(:amount).to_f
  end

  def total_tickets
    tickets.sum(:total).to_f
  end

  def total_cash
    tickets.cash.sum(:total).to_f
  end

  def total_ccard
    tickets.ccard.sum(:total).to_f
  end

  def total_pending
    val = tickets.where(credit: true).sum(:total).to_f
    sign = val > 0 ? -1 : 1
    val * sign
  end

  def total_payments
    ticket_payments.sum(:amount)
  end

  def count_items
    it_tickets = ItemTicket.where(ticket_id: self.tickets.map(&:id))
    by_items = {}
    it_tickets.each do |it|
      if it.item
        item = it.item
        by_items[item.description] = { total: 0, subtotal: 0 } if by_items[item.description].nil?
        by_items[item.description][:total]    += it.quantity
        by_items[item.description][:subtotal] += it.sub_total
      end
    end

    by_items
  end

  def add_closed_data
    self.closing_cash = total_tickets - total_expenses + opening_cash - total_pending + total_payments
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
