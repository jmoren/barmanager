class ItemTicket < ActiveRecord::Base
  belongs_to :item
  belongs_to :ticket
  belongs_to :cancel_reason, required: false

  validates  :item_id, :quantity, presence: true
  validates  :quantity, numericality: { only_integer: true, greater_than: 0 }

  before_save :set_sub_total

  acts_as_paranoid

  def set_sub_total
    price = self.item.price
    self.sub_total = price * self.quantity
  end

  def full_delivered?
    delivered
  end
end
