class Additional < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :cancel_reason
  
  validates :description, :amount, presence: true
  validates :amount, numericality: true

  after_create :update_ticket_after_create
  before_destroy :update_ticket_before_delete

  acts_as_paranoid

  def update_ticket_before_delete
    subtotal = self.ticket.total - self.amount
    self.ticket.update(total: subtotal)
  end

  def update_ticket_after_create
    subtotal = self.ticket.total + self.amount
    self.ticket.update(total: subtotal)
  end

  def full_delivered?
    delivered
  end
end
