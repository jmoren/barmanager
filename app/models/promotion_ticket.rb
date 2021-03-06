class PromotionTicket < ActiveRecord::Base
  belongs_to :promotion
  belongs_to :ticket
  belongs_to :cancel_reason
  has_many   :promotion_ticket_items, dependent: :destroy

  validates :promotion_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  before_create :set_sub_total
  after_create :update_ticket_after_create, :add_promotion_ticket_item
  before_destroy :update_ticket_before_delete

  acts_as_paranoid
  acts_as_commentable


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

  def deliver_all_kitchen
    promotion_ticket_items
      .joins(promotion_item: {item: :category})
      .where("categories.kitchen = true").map(&:deliver_all)
  end

  def full_delivered?
    !self.promotion_ticket_items.map(&:delivered?).include?(false)
  end
end
