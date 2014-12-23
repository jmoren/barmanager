class Ticket < ActiveRecord::Base
  PAYMENT_TYPE= [
    [1, "Cartao de credito"],
    [2, "Efetivo"],
    [3, "Combinado"],
    [4, "Cheque"]
  ]
  belongs_to :table
  has_many :item_tickets

  scope :cartao, -> { where(payment: 1) }
  scope :efetivo, -> { where(payment: 2) }
  scope :combinado, -> { where(payment: 3) }
  scope :cheque, -> { where(payment: 4) }

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
