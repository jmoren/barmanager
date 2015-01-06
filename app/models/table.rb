class Table < ActiveRecord::Base
  has_many :tickets

  validates :number, presence: true
  validates :number, uniqueness: true
  validates :number, numericality: { only_integer: true }

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
