class AddCancelReasonRefToPromotion < ActiveRecord::Migration
  def change
    add_reference :promotion_tickets, :cancel_reason, index: true, foreign_key: true
  end
end
