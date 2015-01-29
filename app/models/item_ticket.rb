class ItemTicket < ActiveRecord::Base
  belongs_to :item
  belongs_to :ticket

  validates :item_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  before_save :set_sub_total

  def set_sub_total
    price = self.item.price
    self.sub_total = price * self.quantity
  end

  def full_delivered?
    delivered
  end
end
