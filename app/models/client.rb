class Client < ActiveRecord::Base
  has_many :tickets, dependent: :destroy

  def doubt
    tickets_total  = self.tickets.sum(:total)
    payments_total = TicketPayment.joins(:ticket).where('tickets.client_id = ?', self.id).sum(:amount)
    tickets_total - payments_total
  end
end
