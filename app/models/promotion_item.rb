class PromotionItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :promotion
  has_many :promotion_ticket_items, dependent: :destroy


  validates :item, :presence => { :message => "Debes seleccionar un Producto" }

  validates :quantity, numericality: { greater_than: 0, message: "La cantidad de productos debe ser mayor a 0" }
end
