class Table < ActiveRecord::Base
  has_many :tickets

  scope :open, -> { where(status: "open") }
  scope :closed, -> { where(status: "closed") }

  def name
    if self.description.present?
      self.description
    else
      "Nro. #{self.id}"
    end
  end
  def open?
    self.status == "open"
  end

  def open!(old_ticket=nil)
    self.update(status: "open")
    ticket          = old_ticket || self.tickets.new
    if old_ticket.nil?
      ticket.date     = Time.now
      ticket.total    = 0
      ticket.status   = "open"
      ticket.save
    end
  end

  def close!
    self.update(status: "closed")
  end

  def kitchen_item_tickets
    self.tickets.where(status: :open).last.item_tickets
      .joins(item: [:category]).where("categories.kitchen = ? and item_tickets.delivered = ?", true, false)
      .order("item_tickets.created_at desc")
  end

  def kitchen_promotion_tickets
    self.tickets.where(status: :open).last.promotion_tickets
      .joins([{promotion: {items: :category}}, :promotion_ticket_items])
      .where("categories.kitchen = ?", true)
      .order("promotion_tickets.created_at desc")
      .uniq
  end

end
