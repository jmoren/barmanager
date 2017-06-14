class Ticket < ActiveRecord::Base
  paginates_per 5

  PAYMENT_TYPE= {
    ccard: { value: 1, title: "Tarjeta de credito" },
    cash:  { value: 2, title: "Efectivo" }
  }.freeze

  belongs_to :table
  belongs_to :shift
  belongs_to :client

  has_many :item_tickets, dependent: :destroy
  has_many :promotion_tickets, dependent: :destroy
  has_many :additionals, dependent: :destroy

  has_many :items, through: :item_tickets
  has_many :promotions, through: :promotion_tickets

  validates :date, :status, :total, presence: true
  validates :total, numericality: true
  validates :status, inclusion: ['open', 'closed']

  before_create :set_serial_number

  scope :without_table, -> { where("client_id IS NULL AND table_id IS NULL")}
  scope :with_table,    -> { where("client_id IS NOT NULL OR table_id IS NOT NULL") }

  scope :closed, -> { where(status: 'closed') }
  scope :opened, -> { where(status: 'open') }
  scope :cash,   -> { where("payment = ? AND (credit = ? OR credit IS NULL)", PAYMENT_TYPE[:cash][:value], false)}
  scope :ccard,  -> { where("payment = ? AND (credit = ? OR credit IS NULL)", PAYMENT_TYPE[:ccard][:value], false)}

  def formatted_number
    "%0.6d" % self.number
  end

  def set_serial_number
    next_number = Ticket.last.nil? ? '1' : Ticket.last.number + 1
    self.credit = false
    self.number = next_number
  end

  def open?
    self.status == "open"
  end

  def close!(credit_param, payment_param = 2)
    self.update(status: "closed", total: self.get_total, shift_id: Shift.last_open.id, credit: credit_param, payment: payment_param)
    self.table.close! if self.table

    if self.credit && self.client
      self.client.doubt += self.total
      self.client.save
    end
  end

  def has_items?
    items.count > 0 || promotions.size > 0 || additionals.size > 0
  end

  def get_total
    self.total = item_tickets.sum(:sub_total) + promotion_tickets.sum(:subtotal) + additionals.sum(:amount)
    self.total
  end

  def deliver_all_kitchen
    item_tickets.update_all(delivered: true)
    promotion_tickets.map(&:deliver_all_kitchen)
    additionals.update_all(delivered: true)
  end

  def grouped_item_tickets
    if self.status == 'closed'
      self.item_tickets.with_deleted.includes(:item, :cancel_reason).group(:item_id, :cancel_reason_id)
        .select("item_tickets.item_id, SUM(item_tickets.quantity) as quantity, SUM(item_tickets.sub_total) as sub_total, MIN(item_tickets.updated_at) as last_update, item_tickets.cancel_reason_id")
    else
      self.item_tickets.includes(:item).group(:item_id)
        .select("item_tickets.item_id, SUM(item_tickets.quantity) as quantity, SUM(item_tickets.sub_total) as sub_total, MIN(item_tickets.updated_at) as last_update")
    end
  end

  def grouped_promotion_tickets
    if self.status == 'closed'
      self.promotion_tickets.with_deleted.includes(:promotion, :cancel_reason).group(:promotion_id, :cancel_reason_id)
        .select("promotion_tickets.promotion_id, SUM(promotion_tickets.quantity) as quantity, SUM(promotion_tickets.subtotal) as subtotal, MIN(promotion_tickets.updated_at) as last_update, promotion_tickets.cancel_reason_id")
    else
      self.promotion_tickets.joins(:promotion).group(:promotion_id)
        .select("promotion_tickets.promotion_id, SUM(promotion_tickets.quantity) as quantity, SUM(promotion_tickets.subtotal) as subtotal, MIN(promotion_tickets.updated_at) as last_update")
    end
  end

  def item_tickets_to_kitchen
    self.item_tickets.with_deleted.joins(item: [:category])
        .where("categories.kitchen = ? and item_tickets.delivered = ?", true, false)
        .order("item_tickets.created_at desc")
  end

  def promotion_tickets_to_kitchen
    self.promotion_tickets.with_deleted
        .joins([{promotion: {items: :category}}, :promotion_ticket_items])
        .where("categories.kitchen = ?", true)
        .order("promotion_tickets.created_at desc")
        .uniq
  end

  def additionals_to_kitchen
    self.additionals.where(kitchen: true)
  end

  def fully_delivered?
    pending_promos = promotion_tickets.map(&:full_delivered?).include?(false)
    pending_kitchen_additionals = additionals.where(kitchen: true).map(&:full_delivered?).include?(false)
    pending_kitchen_items = item_tickets.joins(item: :category).where(categories: { kitchen: true }).map(&:full_delivered?).include?(false)

    !pending_promos && !pending_kitchen_additionals && !pending_kitchen_items
  end

  def get_printed_at
    self.printed_at || self.created_at
  end
end
