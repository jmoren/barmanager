class Client < ActiveRecord::Base
  has_many :tickets, dependent: :destroy
  has_many :ticket_payments

  def doubt
    tickets_closed_total  = self.tickets.closed.sum(:total)
    tickets_opened_total  = self.tickets.opened.sum(&:get_total)
    payments_total = self.ticket_payments.sum(:amount)
    tickets_closed_total + tickets_opened_total - payments_total
  end
end
