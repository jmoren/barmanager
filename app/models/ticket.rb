class Ticket < ActiveRecord::Base
  paginates_per 5

  PAYMENT_TYPE= [
    [1, "Tarjeta de credito"],
    [2, "Efectivo"]
  ].freeze

  belongs_to :table
  belongs_to :shift
  has_many :item_tickets, dependent: :destroy
  has_many :promotion_tickets, dependent: :destroy
  has_many :additionals, dependent: :destroy

  has_many :items, through: :item_tickets
  has_many :promotions, through: :promotion_tickets

  validates :table_id, :shift_id, :date, :status, :total, presence: true
  validates :total, numericality: true
  validates :status, inclusion: ['open', 'closed']

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

  def has_items?
    items.size > 0 || promotions.size > 0
  end
end
