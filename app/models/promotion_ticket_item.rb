class PromotionTicketItem < ActiveRecord::Base
  belongs_to :promotion_ticket
  belongs_to :promotion_item

  def delivered?
    self.delivered == (self.promotion_item.quantity * self.promotion_ticket.quantity)
  end
end
