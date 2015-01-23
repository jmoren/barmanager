class Table < ActiveRecord::Base
  has_many :tickets

  validates :number, presence: true
  validates :number, numericality: { only_integer: true }

  scope :open, -> { where(status: "open") }
  scope :closed, -> { where(status: "closed") }

  def name
    if self.description
      "#{self.description} - ##{self.number}"
    else
      "Nro. #{self.number}"
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
      ticket.shift    = Shift.last
      ticket.save
    end
  end

  def close!
    self.update(status: "closed")
  end

end
