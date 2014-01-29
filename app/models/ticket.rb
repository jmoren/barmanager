class Ticket < ActiveRecord::Base
  belongs_to :table
  has_many :item_tickets

  before_create :set_serial_number

  def formatted_number
    "%0.6d" % self.number
  end

  def set_serial_number
    next_number = Ticket.last.nil? ? '1' : Ticket.last.number + 1
    self.number = next_number
  end

  def close!
    self.update(status: "closed")
  end

  def open?
    self.status == "open"
  end
end
