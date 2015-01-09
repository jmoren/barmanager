class PromotionTicketItem < ActiveRecord::Base
  belongs_to :promotion_ticket
  belongs_to :promotion_item

end
