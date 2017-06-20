class ItemTicket < ActiveRecord::Base
  belongs_to :item
  belongs_to :ticket
  belongs_to :cancel_reason, required: false

  validates  :item_id, :quantity, presence: true
  validates  :quantity, numericality: { only_integer: true, greater_than: 0 }

  scope :pending_kitchen, -> { joins(item: [:category]).where("categories.kitchen = ? and item_tickets.delivered = ?", true, false) }

  before_save :set_sub_total

  acts_as_paranoid
  acts_as_commentable

  def set_sub_total
    price = self.item.price
    self.sub_total = price * self.quantity
  end

  def full_delivered?
    delivered
  end
end
