class PromotionTicketsController < ApplicationController
  before_action :set_ticket
  before_action :set_promotion_ticket, only: [:destroy, :increase_delivered, :decrease, :deliver]

  def create
    @promotion_ticket = @ticket.promotion_tickets.new(promotion_ticket_params)
    @promotion_ticket.save
    redirect_to @ticket
  end

  def bulk
    params[:promo_ticket].each do |pt|
      unless pt["promo_id"].empty? || pt["quantity"].empty?
        promo_ticket = PromotionTicket.create(promotion_id: pt["promo_id"], quantity: pt["quantity"], ticket: @ticket)
        @ticket.promotion_tickets << promo_ticket
        promo_ticket.comments.create(title: "Promo ticket comment", comment: pt["comment"]) unless pt["comment"].empty?
      end
    end
    @ticket.save
    redirect_to @ticket
  end

  def delete
    @url = params[:quantity] == "all" ? ticket_destroy_all_ticket_promotion_tickets_path : ticket_promotion_ticket_path
    render :delete, layout: false
  end

  def destroy
    reason_id = params.require(:cancel_reason_id)

    ActiveRecord::Base.transaction do
      @promotion_ticket.update(cancel_reason_id: reason_id)
      @promotion_ticket.destroy
    end

    redirect_to @ticket
  end

  def increase_delivered
    prom_tick_item = @promotion_ticket.promotion_ticket_items.find(params[:prod_id])
    if prom_tick_item.delivered < prom_tick_item.promotion_item.quantity * @promotion_ticket.quantity
      prom_tick_item.delivered += params[:quantity].to_i
      prom_tick_item.save
    end
    redirect_to :back
  end

  def deliver
    if params[:promotion_ticket_item]
      PromotionTicketItem.find(params[:promotion_ticket_item]).deliver_all
    else
      @promotion_ticket.deliver_all_kitchen
    end

    redirect_to :back
  end

  def increase
    new_promotion_ticket = @ticket.promotion_tickets.where(promotion_id: params[:id]).last.dup
    new_promotion_ticket.quantity = 1
    new_promotion_ticket.set_sub_total
    new_promotion_ticket.save
    redirect_to @ticket
  end

  def destroy_all
    reason_id = params.require(:cancel_reason_id)
    promos = @ticket.promotion_tickets.where(promotion_id: params[:id])
    ActiveRecord::Base.transaction do
      promos.update_all(cancel_reason_id: reason_id)
      promos.destroy_all
    end

    redirect_to @ticket
  end

  private
  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_promotion_ticket
    @promotion_ticket = PromotionTicket.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def promotion_ticket_params
    params.require(:promotion_ticket).permit(:ticket_id, :promotion_id, :quantity)
  end
end
