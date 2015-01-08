class PromotionTicket < ActiveRecord::Base
  belongs_to :promotion
  belongs_to :ticket

  validates :promotion_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  before_create :set_sub_total
  after_create :update_ticket_after_create, :update_stock_after_create
  before_destroy :update_ticket_before_delete, :update_stock_before_destroy

  def set_sub_total
    price = self.promotion.price
    self.subtotal = price * self.quantity
  end

  def update_ticket_before_delete
    sub_total = self.ticket.total - self.subtotal
    self.ticket.update(total: sub_total)
  end

  def update_ticket_after_create
    sub_total = self.ticket.total + self.subtotal
    self.ticket.update(total: sub_total)
  end

  def update_stock_after_create
    promotion.promotion_items.each do |promo_item|
      current_stock = promo_item.item.stock - promo_item.quantity
      promo_item.item.update(stock: current_stock)
    end
  end

  def update_stock_before_destroy
    promotion.promotion_items.each do |promo_item|
      current_stock = promo_item.item.stock + promo_item.quantity
      promo_item.item.update(stock: current_stock)
    end
  end
end
