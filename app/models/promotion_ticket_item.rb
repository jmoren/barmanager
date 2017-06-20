class PromotionTicketItem < ActiveRecord::Base
  belongs_to :promotion_ticket
  belongs_to :promotion_item

  delegate :ticket, :to => :promotion_ticket, :allow_nil => false

  scope :pending_kitchen, -> { joins(:promotion_ticket, promotion_item: { item: :category}).where("promotion_ticket_items.delivered < promotion_tickets.quantity * promotion_items.quantity AND categories.kitchen = ?", true) }

  def delivered?
    self.delivered == self.quantity
  end

  def deliver_all
    self.update(delivered: (self.promotion_item.quantity * self.promotion_ticket.quantity))
  end

  def pending
    (self.promotion_item.quantity * self.promotion_ticket.quantity) - self.delivered
  end

  def quantity
    self.promotion_item.quantity * self.promotion_ticket.quantity
  end

  def ticket_id
    self.ticket.id
  end

  def deleted_at
    promotion_ticket.deleted_at
  end

  def created_at
    promotion_ticket.created_at
  end

end
