class PromotionItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :promotion
end