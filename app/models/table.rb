class Table < ActiveRecord::Base
  has_many :tickets

  STATUS = ["open", "closed"]

  def open?
    self.status == "open"
  end

  def open!
    self.update(status: "open")
    ticket = self.tickets.new
    ticket.date     = Time.now
    ticket.total    = 0
    ticket.status   = "open"

    ticket.save
  end

  def close!
    self.update(status: "closed")
  end

end
