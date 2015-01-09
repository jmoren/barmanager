class PromotionItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :promotion
  has_many :promotion_ticket_items, dependent: :destroy
end