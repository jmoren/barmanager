class PromotionTicket < ActiveRecord::Base
  belongs_to :promotion
  belongs_to :ticket

  validates :item_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  before_create :set_sub_total
  after_create :update_ticket_after_create, :update_stock_after_create
  before_destroy :update_ticket_before_delete, :update_stock_before_destroy

  def set_sub_total
    #price = self.item.price
    #self.sub_total = price * self.quantity
  end

  def update_ticket_before_delete
    #subtotal = self.ticket.total - self.sub_total
    #self.ticket.update(total: subtotal)
  end

  def update_ticket_after_create
    #subtotal = self.ticket.total + self.sub_total
    #self.ticket.update(total: subtotal)
  end

  def update_stock_after_create
    #current_stock = self.item.stock - self.quantity
    #self.item.update(stock: current_stock)
  end

  def update_stock_before_destroy
    #current_stock = self.item.stock + self.quantity
    #self.item.update(stock: current_stock)
  end
end
