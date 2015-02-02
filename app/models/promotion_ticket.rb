class PromotionTicket < ActiveRecord::Base
  belongs_to :promotion
  belongs_to :ticket
  has_many   :promotion_ticket_items, dependent: :destroy

  validates :promotion_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  before_create :set_sub_total
  after_create :update_ticket_after_create, :add_promotion_ticket_item
  before_destroy :update_ticket_before_delete

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

  def add_promotion_ticket_item
    promotion.promotion_items.each do |i|
      self.promotion_ticket_items.create(promotion_item_id: i.id)
    end
  end

  def deliver_all
    promotion_ticket_items.update_all(delivered: true)
  end

  def full_delivered?
    self.promotion_ticket_items.map(&:delivered?).select { |a| !a }.empty?
  end
end
