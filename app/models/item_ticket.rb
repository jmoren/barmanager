class ItemTicket < ActiveRecord::Base
  belongs_to :item
  belongs_to :ticket

  validates :item_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  before_create :set_sub_total
  after_create :update_ticket_after_create
  before_destroy :update_ticket_before_delete

  def set_sub_total
    price = self.item.price
    self.sub_total = price * self.quantity
  end

  def update_ticket_before_delete
    subtotal = self.ticket.total - self.sub_total
    self.ticket.update(total: subtotal)
  end

  def update_ticket_after_create
    subtotal = self.ticket.total + self.sub_total
    self.ticket.update(total: subtotal)
  end
end
