class Table < ActiveRecord::Base
  has_many :tickets

  STATUS = ["open", "closed"]

  def open?
    self.status == "open"
  end

  def open!
    self.update(status: "open")
    self.tickets.create(trend_id: 1, date: Time.now, total: 0, status: "open")
  end

  def close!
    self.update(status: "closed")
    self.tickets.last.close! if self.tickets.last && self.open?
  end

end
